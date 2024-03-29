BaseApp::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "pages/index"

  get "pages/dashboard"

  match "/dashboard" => "pages#dashboard", :as => "dashboard"

  root :to => "pages#index"

end
