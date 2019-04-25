Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        resources :dogs do
          resources :appointments
        end
      end
      post "/login", to: "users#login", as: :login
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
