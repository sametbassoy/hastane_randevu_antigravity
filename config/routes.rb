Rails.application.routes.draw do
  get 'appointments/create'
  get 'doctors/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/doctors/available', to: 'doctors#index'
  post '/appointments', to: 'appointments#create'

  # Defines the root path route ("/")
  # root "posts#index"
end
