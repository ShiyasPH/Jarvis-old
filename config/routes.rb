Rails.application.routes.draw do
  root 'home#welcome'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get 'home/welcome'
  get 'home/dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
