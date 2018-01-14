Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      concern :commentable do
        resources :comments, shallow: true
      end

      concern :votable do
        resources :votes, except: :update, shallow: true
      end

      resources :users do
        resources :sessions, shallow: true, except: :update

        resources :questions, shallow: true, concerns: [:commentable, :votable] do
          resources :answers, shallow: true, concerns: [:commentable, :votable]
        end
      end

      resources :questions, only: :index
    end
  end
end
