Rails.application.routes.draw do
	devise_for :users
  
  get '/' => 'site#home'

  #get '/users/sign_in' => 'devise/sessions#new'

  resources :users do
    resources :issues
  end



  resources :comments, only: [:create]

end