Rails.application.routes.draw do
  devise_for :users
  resources :home, only: %i[index new create show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
