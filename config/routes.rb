Rails.application.routes.draw do
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
  resources :alerts
  resources :energies
  resources :devices
  resources :homes_users
  resources :homes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
