Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :articles, except: %i[new edit] do
        scope module: :articles do
          resources :likes, only: %i[index create]
          resources :comments, only: %i[index create]
          get 'search', on: :collection, to: 'search#index'
        end
      end
    end
  end

  root to: 'home#index'
end
