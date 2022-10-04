Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :home, only: %i[index new create show]
  post '/comment', to: 'home#comment_create'
  post '/likeable/:id/:bool', to: 'home#likeable', as: 'likeable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
