Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :motion_alert_logs
  resources :temp_alert_logs
  resources :energy_alert_logs
  resources :light_alert_logs
  resources :hum_alert_logs
  resources :alert_settings
  resources :lights
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
