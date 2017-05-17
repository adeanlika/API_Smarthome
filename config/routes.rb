Rails.application.routes.draw do

  resources :energy_alert_logs
  resources :lights

  resources :carbondioxides
  mount_devise_token_auth_for 'User', at: 'auth'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


post 'test', to: 'devices#test'
get 'data_energy', to: 'energies#get_data_energy'
get 'data_sensor', to: 'devices#get_data_sensor'
#get 'current', to: 'homes#current'
  # post 'carbondioxides_daily', to: 'carbondioxides#daily'
  # post 'carbondioxides_weekly', to: 'carbondioxides#weekly'
  # post 'carbondioxides_monthly', to: 'carbondioxides#monthly'
  # post 'carbondioxides_yearly', to: 'carbondioxides#yearly'
  resources :motions
  resources :humidities
  resources :temperatures
  resources :energies

  resources :homes_users
  resources :homes do
    get 'current_energy', to: 'homes#current_energy'
    get 'cost', to: 'homes#cost'
    get 'presentase', to: 'homes#presentase'
    post 'energy_daily', to: 'energies#daily'
    post 'energy_weekly', to: 'energies#weekly'
    post 'energy_monthly', to: 'energies#monthly'
    post 'energy_yearly', to: 'energies#yearly'

    resources :devices do

        get 'current_sensor', to: 'homes#current'
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

        post 'lights_daily', to: 'lights#daily'
        post 'lights_weekly', to: 'lights#weekly'
        post 'lights_monthly', to: 'lights#monthly'
        post 'lights_yearly', to: 'lights#yearly'
      resources :alert_logs
      resources :relays
        put 'aktuator', to: 'relays#actuator'


      end
  end
 resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
