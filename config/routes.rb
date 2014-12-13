Rails.application.routes.draw do
	devise_for :users, controllers: { sessions: "users/sessions" }
  
  get '/' => 'site#home'

  #get '/users/sign_in' => 'devise/sessions#new'

  resources :users do
    resources :issues
  end



  resources :comments, only: [:create, :new]

end