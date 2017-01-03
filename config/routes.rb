Rails.application.routes.draw do
  resources :categories
  devise_for :users
  # get 'welcome/index'
  root 'welcome#index'
  resources :articles

  # Creando ruta para el Dashboard
  # Le estoy diciendo que la ruta /dashboard el que va a responder será el controlador welcome#dashboard
  get '/dashboard', to: 'welcome#dashboard'

end
