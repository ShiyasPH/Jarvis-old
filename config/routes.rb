Rails.application.routes.draw do
  authenticated :user do
    root to: 'home#dashboard', as: :authenticated_root
  end
  root to: 'home#welcome'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
