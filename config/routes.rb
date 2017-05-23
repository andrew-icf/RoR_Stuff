Rails.application.routes.draw do
  root 'street_cafes#index'

  # resources :street_cafes appending to the app regardless (get /street_cafes/123 built in)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
