Rails.application.routes.draw do
  get 'home/index'
	root 'home#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

	resources :users, only: [:show, :index]
end
