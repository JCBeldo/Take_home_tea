Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :create] do
        resources :subscriptions, only: [:index]
      end
      resources :subscriptions, only: [:index, :create]
    end
  end
end
