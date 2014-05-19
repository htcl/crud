Rails.application.routes.draw do
  mount Crud::Engine => "/crud", :as => :crud
  root :to => "crud/dashboard#index"
end
