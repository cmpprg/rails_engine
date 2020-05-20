Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'item_merchant#show'
      end
    end
  end
end
