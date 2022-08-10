# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api, module: :api do
    scope module: :v1, constraints: ApiVersionConstraint.new('v1') do
      resources :users, only: %i[create]
      post '/login', to: 'users#login'
      resources :questions do
        resources :answers
      end
    end
  end
end
