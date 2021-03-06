Rails.application.routes.draw do

  resources :ac_brands
  root to: redirect('/admin')
  devise_for :superusers, controllers: {
    sessions: 'superusers/sessions',
    passwords: 'superusers/passwords',
    registrations: 'superusers/registrations'
  }
  resources :alerts
  resources :lights

  resources :carbondioxides
  mount_devise_token_auth_for 'User', at: 'auth'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'



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
    post 'add_member', to: 'homes_users#add_member'
    delete 'delete_member', to: 'homes_users#delete_member'
    get 'home_member', to: 'homes_users#home_member'
    get 'admin_filter', to: 'homes_users#admin_filter'
    put 'set_admin', to: 'homes_users#set_admin'
    get 'alert', to: 'alerts#current_notif'
    get 'alert_details', to: 'alerts#alert_by_date'
    get 'test', to: 'devices#test'
    get 'current_energy', to: 'energies#current_energy'
    get 'cost', to: 'energies#cost'
    get 'presentase', to: 'energies#presentase'
    get 'cost_chart', to: 'energies#cost_chart'
    get 'energy_chart', to: 'energies#energy_chart'
    post 'set_energy_limit', to: 'homes#set_energy_limit'
    post 'set_supply', to: 'homes#set_supply'
    post 'energy_hourly', to: 'energies#hourly'
    post 'energy_daily', to: 'energies#daily'
    post 'energy_weekly', to: 'energies#weekly'
    post 'energy_monthly', to: 'energies#monthly'
    post 'energy_yearly', to: 'energies#yearly'
    post 'current_hourly', to: 'energies#current_hourly'
    post 'current_daily', to: 'energies#current_daily'
    post 'voltage_hourly', to: 'energies#voltage_hourly'
    post 'voltage_daily', to: 'energies#voltage_daily'
    post 'power_hourly', to: 'energies#power_hourly'
    post 'power_daily', to: 'energies#power_daily'
    post 'cost_hourly', to: 'energies#cost_hourly'
    post 'cost_daily', to: 'energies#cost_daily'
    post 'cost_monthly', to: 'energies#cost_monthly'
    post 'cost_yearly', to: 'energies#cost_yearly'
    get 'energy_saving', to: 'energies#saving_daily'
      resources :devices do
        get 'current_sensor', to: 'devices#current_sensor'
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
          resources :relays
        put 'aktuator', to: 'relays#actuator'
      end
  end
 resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
