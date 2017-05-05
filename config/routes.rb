Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      resources :survivors, except: :destroy do
        member do
          get "flag_infected", to: "survivors#flag_infected"
        end
      end
    end
  end
end
