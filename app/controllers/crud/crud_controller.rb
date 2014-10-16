require_dependency "crud/crud_base_controller"

module Crud
  class CrudController < CrudBaseController
    around_filter :catch_not_found

    before_filter :is_allowed_to_view?, :only => [:index, :show]
    before_filter :is_allowed_to_update?, :only => [:new, :create, :edit, :update, :destroy, :delete]
    before_filter :get_klass_info_from_params
    before_filter :get_visible_attributes

    # GET
    def index
      @search_prompt = I18n.t(:search_prompt)

      page = (params[:page]) ? params[:page].to_i : 1
      per_page = (params[:per_page]) ? params[:per_page].to_i : 10

      if( params[:search] && !params[:search].empty? && params[:search] != @search_prompt)
        where_clause = ''
        @visible_attributes.each do |attribute|
          where_clause += "LOWER(#{attribute[:column_name]}) LIKE '%#{params[:search].downcase}%' OR " if attribute[:column_data_type] == :string
        end
        where_clause.sub!(/ OR $/,'')
      else
        where_clause = nil
      end

      primary_key_name = @klass_info.primary_key(@klass_info[:class])
      if primary_key_name
        @klass_data = @klass_info[:class].where(where_clause).paginate(:page => page, :per_page => per_page).order("#{primary_key_name} ASC")
      else
        @klass_data = @klass_info[:class].where(where_clause).paginate(:page => page, :per_page => per_page)
      end

      respond_to do |format|
        format.html # index.html.erb
        format.js   # index.js.erb
        format.json { render :json => @klass_data }
        format.xml  { render :xml => @klass_data }
      end
    end

    # GET
    def show
      @klass_data = @klass_info[:class].find(params[:id])

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @klass_data }
        format.xml  { render :xml => @klass_data }
      end
    end

    # GET
    def new
      @klass_data = @klass_info[:class].new

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @klass_data }
        format.xml  { render :xml => @klass_data }
      end
    end

    # GET
    def edit
      @klass_data = @klass_info[:class].find(params[:id])
    end

    # POST
    def create
      @klass_data = @klass_info[:class].new(params[@klass_info[:name_as_sym]])

      respond_to do |format|
        if @klass_data.save
          format.html { redirect_to show_path(:class_name => @klass_info[:name], :id => @klass_data.id), :notice => "#{@klass_info[:name]} was successfully created" }
          format.json { render :json => @klass_data, :status => :created, :location => @klass_data }
          format.xml  { head :ok }
        else
          format.html { render :action => 'new' }
          format.json { render :json => @klass_data.errors, :status => :unprocessable_entity }
          format.xml  { render :xml => @klass_data.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT
    def update
      @klass_data = @klass_info[:class].find(params[:id])

      respond_to do |format|
        if @klass_data.update_attributes(params[@klass_info[:name_as_sym]])
          format.html { redirect_to show_path(:class_name => @klass_info[:name], :id => @klass_data.id), :notice => "#{@klass_info[:name]} was successfully updated" }
          format.json { head :no_content }
          format.xml  { head :ok }
        else
          format.html { render :action => 'edit' }
          format.json { render :json => @klass_data.errors, :status => :unprocessable_entity }
          format.xml  { render :xml => @klass_data.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE
    def delete
      @klass_data = @klass_info[:class].find(params[:id])
      @klass_data.delete

      respond_to do |format|
        format.html { redirect_to index_path(:class_name => @klass_info[:name]), :notice => "#{@klass_info[:name]}[#{params[:id]}] was successfully deleted" }
        format.json { head :no_content }
        format.xml  { head :ok }
      end
    end

    # DELETE
    def destroy
      @klass_data = @klass_info[:class].find(params[:id])
      @klass_data.destroy

      respond_to do |format|
        format.html { redirect_to index_path(:class_name => @klass_info[:name]), :notice => "#{@klass_info[:name]}[#{params[:id]}] was successfully destroyed" }
        format.json { head :no_content }
        format.xml  { head :ok }
      end
    end

    private

    def get_klass_info_from_params
      if params[:class_name]
        @klass_info = ::Crud::KlassInfo.new(params[:class_name].constantize)
      else
        render :text => "Missing class identifier"
      end
    end

    def get_visible_attributes
      @visible_attributes =  @klass_info.visible_attributes(self.action_name.to_sym)
    end

    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to back_url, :flash => { :error => "#{@klass_info[:name]} record with id=[#{params[:id]}] not found" }
    end
  end
end
