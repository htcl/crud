Crud::Engine.routes.draw do

  controller 'crud' do
    match '/model/*class_name/new',         :to => :new,        :via => :get,    :as => :new
    match '/model/*class_name/:id/delete',  :to => :delete,     :via => :delete, :as => :delete
    match '/model/*class_name/:id/edit',    :to => :edit,       :via => :get,    :as => :edit
    match '/model/*class_name/:id',         :to => :show,       :via => :get,    :as => :show
    match '/model/*class_name/:id',         :to => :update,     :via => :put,    :as => :update
    match '/model/*class_name/:id',         :to => :destroy,    :via => :delete, :as => :destroy
    match '/model/(*class_name)',           :to => :create,     :via => :post,   :as => :create
    match '/model/(*class_name)',           :to => :index,      :via => :get,    :as => :index
  end

  #get 'dashboard' => 'dashboard#index'
  root :to => "dashboard#index"
end
