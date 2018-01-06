Rails.application.routes.draw do
  get 'comments/create'

  get 'comments/update'

  get 'comments/destroy'

  get 'sessions/create'

  get 'sessions/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :questions
  resources :answers, only: %i[create update destroy]
  resources :comments, only: %i[create update destroy]
  resources :votes, only: %i[create destroy]

  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#destroy'
end
