Rails.application.routes.draw do

  get '/' => 'site#home'

  resources :users do
    resources :issues
  end

  resources :comments, only: [:create]

end