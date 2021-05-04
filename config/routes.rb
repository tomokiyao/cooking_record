Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :my_cookings, only: :index
  resources :recipes, only: :index
  
  root to: 'my_cookings#index'

  namespace :api do
    namespace :internal do
      resources :fetch_cooking_records, only: :index
      resources :bookmarks, only: [:index, :create]
    end
  end
end
