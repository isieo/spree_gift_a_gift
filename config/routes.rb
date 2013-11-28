Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  resources :redeem
  namespace :admin do
    resources :gifts
  end
end
