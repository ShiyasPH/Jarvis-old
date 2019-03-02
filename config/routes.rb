Rails.application.routes.draw do
  devise_for :users
  root 'home#welcome'
  
  get 'home/welcome'
  get 'home/dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
