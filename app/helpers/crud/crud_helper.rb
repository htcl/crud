module Crud
  module CrudHelper

    def options_for_select_tag
      options_for_select(@klass_list.all.collect{|klass| [klass.to_s, index_path(:class_name => klass)]})
    end

    def edit_field_for_attribute(klass_info, row, attribute, f)
      begin
        html = []
        if ['id','created_at', 'updated_at'].include?(attribute[:column_name])
          html << '(auto)'
        elsif attribute[:association] == :belongs_to
          unless(attribute[:association_polymorphic])
            html << f.collection_select(attribute[:column_name].to_sym, attribute[:association_class].all, :id, :to_s, :include_blank => true)
          else
            associated_attribute = klass_info.associated_polymorphic_attribute(attribute)
            if associated_attribute && associated_attribute.length == 1 && row.attributes[associated_attribute[0][:column_name]]
              html << f.collection_select(attribute[:column_name].to_sym, row.attributes[associated_attribute[0][:column_name]].constantize.all, :id, :to_s, :include_blank => true)
            else
              html << f.text_field(attribute[:column_name].to_sym)
            end
          end
        else
          case attribute[:column_data_type]
          when :text
            html << f.text_area(attribute[:column_name].to_sym, :rows => 6, :cols => 80)
          when :datetime
            html << f.datetime_select(attribute[:column_name].to_sym, :include_blank => true)
          when :date
            html << f.date_select(attribute[:column_name].to_sym, :discard_year => false, :include_blank => true)
          when :time
            html << f.time_select(attribute[:column_name].to_sym, :include_seconds => true, :include_blank => true)
          when :boolean
            html << f.select(attribute[:column_name].to_sym, [['True', true], ['False', false]], :include_blank => true)
          else
            html << f.text_field(attribute[:column_name].to_sym)
          end
        end
        html.join
      rescue Exception => e
        Rails.logger.info "#{e.class}: #{e.message}#$/#{e.backtrace.join($/)}"
        "problem constructing edit field for '#{attribute[:column_name].to_s}'"
      end
    end

    def render_attribute_value(attribute, klass_data)
      # Parameters :attribute => attribute, :klass_data => row_data
      custom_fields = @klass_info.custom_fields(attribute[:column_name], controller.action_name.to_sym)
      custom_fields_contain_a_replacement = @klass_info.custom_fields_contain_a_replacement(custom_fields)

      unless custom_fields_contain_a_replacement
        attribute_value_from_row = @klass_info.attribute_value_from_row(attribute, klass_data)
        formatted_output = attribute_value_from_row[1] ? "[#{attribute_value_from_row[0]}] #{attribute_value_from_row[1]}" : "#{attribute_value_from_row[0]}"

        unless (attribute[:association] && attribute[:association] == :belongs_to)
          return formatted_output
        else
          unless attribute[:association_polymorphic]
            return link_to formatted_output, show_path(:class_name => attribute[:association_class].name, :id => attribute_value_from_row[0])
          else
            associated_polymorphic_class = @klass_info.associated_polymorphic_class(attribute, klass_data)
            if associated_polymorphic_class
              return link_to formatted_output, show_path(:class_name => associated_polymorphic_class.name, :id => attribute_value_from_row[0])
            else
              return formatted_output
            end
          end
        end
      else
        ''.html_safe
      end

    end

    def render_custom_fields(attribute, klass_data, klass_info)
      out = ''

      custom_fields = klass_info.custom_fields(attribute[:column_name], controller.action_name.to_sym)
      custom_fields.each do |field|
        out += render field[:partial], {field[:record_data_parameter].to_sym => klass_data}.merge(field[:additional_partial_parameters])
        out += '<br/>'
      end

      out.html_safe
    end

    def render_attribute_value_and_custom_fields(attribute, klass_data, klass_info)
      (render_attribute_value(attribute, klass_data) + render_custom_fields(attribute, klass_data, klass_info)).html_safe
    end

    private

    # Handler to send application URIs back to the application
    def method_missing(method, *args, &block)
      if (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && main_app.respond_to?(method)
        main_app.send(method, *args)
      else
        super
      end
    end

  end
end
