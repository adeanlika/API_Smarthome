Rails.application.routes.draw do
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
