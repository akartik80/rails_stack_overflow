Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :questions
  resources :answers, only: %i[create update destroy]

  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#destroy'
end
