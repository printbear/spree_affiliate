Spree::Core::Engine.routes.append do
  namespace :admin do
    resource :affiliate_settings, only: [:edit]
  end

  resources :affiliates, only: [:show]
end
