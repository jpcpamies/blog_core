Rails.application.routes.draw do
  resources :categories
  devise_for :users
  # get 'welcome/index'
  root 'welcome#index'
  resources :articles

  # Creando ruta para el Dashboard
  # Le estoy diciendo que la ruta /dashboard el que va a responder será el controlador welcome#dashboard
  get '/dashboard', to: 'welcome#dashboard'
  # Como publicar va a modificar un recurso ya existente, la acción requerida es put.
  # Esta url tiene el comodin id que se sustituye por cada uno de los article.
  put '/article/:id/publish', to: 'articles#publish'

end
