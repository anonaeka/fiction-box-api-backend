Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :user do
        post "sign_in", to: "users#sign_in"
        post "sign_up", to: "users#sign_up"
        delete "sign_out", to: "users#sign_out"
        get "manage_user", to: "users#manage_user"
        patch "manage_user", to: "users#manage_user_update"
        put "manage_user", to: "users#manage_user_update"
        get "get_user", to: "users#get_user"

        get"manage_fiction", to: "fictions#manage_fiction"
        
        devise_for :users

        resources :fictions
        resources :categories
        resources :reviews
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
