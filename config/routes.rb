Spree::Core::Engine.routes.draw do

  namespace :admin do
    resources :campaigns
  end
end
