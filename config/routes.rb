Rails.application.routes.draw do
  resources :co_alert_logs
  resources :carbondioxides
  mount_devise_token_auth_for 'User', at: 'auth'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'humidities_daily', to: 'humidities#daily'
  post 'humidities_weekly', to: 'humidities#weekly'
  post 'humidities_monthly', to: 'humidities#monthly'
  post 'humidities_yearly', to: 'humidities#yearly'

  post 'temperatures_daily', to: 'temperatures#daily'
  post 'temperatures_weekly', to: 'temperatures#weekly'
  post 'temperatures_monthly', to: 'temperatures#monthly'
  post 'temperatures_yearly', to: 'temperatures#yearly'

  post 'carbondioxide_daily', to: 'carbondioxides#daily'
  post 'carbondioxide_weekly', to: 'carbondioxides#weekly'
  post 'carbondioxide_monthly', to: 'carbondioxides#monthly'
  post 'carbondioxide_yearly', to: 'carbondioxides#yearly'
  resources :motion_alert_logs
  resources :temp_alert_logs
  resources :energy_alert_logs
  resources :hum_alert_logs
  resources :alert_settings
  resources :motions
  resources :humidities
  resources :temperatures
  resources :relays
  resources :energies
  resources :devices
  resources :homes_users
  resources :homes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
