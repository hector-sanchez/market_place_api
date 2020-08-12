Rails.application.routes.draw do
  namespace :api, defaults: { format: :json  } do
    namespace :v1 do
      resources :users, only: %i[create destroy show update]
      resources :tokens, only: [:create]
      resources :products
    end
  end
end
