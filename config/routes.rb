Rails.application.routes.draw do

  get '/' => 'site#home'

  resources :users do
    resources :panel_messages
    resources :conversational_messages
  end

end