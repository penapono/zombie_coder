Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      resources :survivors, except: :destroy do
        member do
          post :flag_infected
          post :trade
        end
      end

      resource :reports, only: [] do
        get :infected, on: :collection
        get :non_infected, on: :collection
        get :average_resource, on: :collection
        get :lost_points, on: :collection
      end
    end
  end
end
