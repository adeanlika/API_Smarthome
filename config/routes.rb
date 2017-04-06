Rails.application.routes.draw do
  resources :alert_logs
  resources :co_alert_logs
  resources :carbondioxides
  mount_devise_token_auth_for 'User', at: 'auth'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

post 'current_energy', to: 'homes#current_energy'
post 'current', to: 'homes#current'
get 'test', to: 'devices#test'

#get 'current', to: 'homes#current'
  # post 'carbondioxides_daily', to: 'carbondioxides#daily'
  # post 'carbondioxides_weekly', to: 'carbondioxides#weekly'
  # post 'carbondioxides_monthly', to: 'carbondioxides#monthly'
  # post 'carbondioxides_yearly', to: 'carbondioxides#yearly'
  resources :motion_alert_logs
  resources :temp_alert_logs
  resources :energy_alert_logs
  resources :hum_alert_logs
  resources :motions
  resources :humidities
  resources :temperatures
  resources :relays
  resources :energies do
    post 'energy_daily', to: 'energies#daily'
    post 'energy_monthly', to: 'energies#monthly'
    post 'energy_yearly', to: 'energies#yearly'

  end

  resources :homes_users
  resources :homes do
    get 'data_energy', to: 'homes#get_data_energy'
    resources :devices do
        get 'get_data_sensor', to: 'devices#get_data_sensor'
        post 'carbondioxides_daily', to: 'carbondioxides#daily'
        post 'carbondioxides_weekly', to: 'carbondioxides#weekly'
        post 'carbondioxides_monthly', to: 'carbondioxides#monthly'
        post 'carbondioxides_yearly', to: 'carbondioxides#yearly'

        post 'humidities_daily', to: 'humidities#daily'
        post 'humidities_weekly', to: 'humidities#weekly'
        post 'humidities_monthly', to: 'humidities#monthly'
        post 'humidities_yearly', to: 'humidities#yearly'

        post 'temperatures_daily', to: 'temperatures#daily'
        post 'temperatures_weekly', to: 'temperatures#weekly'
        post 'temperatures_monthly', to: 'temperatures#monthly'
        post 'temperatures_yearly', to: 'temperatures#yearly'
      end
  end

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
