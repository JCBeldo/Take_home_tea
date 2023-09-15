Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get 'customers', to: 'customers#index'
      post 'customers', to: 'customers#create'
      post 'customers/:id/subscriptions', to: 'customers/subscriptions#create'
      patch 'customers/:id/subscriptions', to: 'customers/subscriptions#update'
      get 'customers/:id/subscriptions', to: 'customers/subscriptions#index'
    end
  end
end
