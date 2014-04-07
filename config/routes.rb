Spree::Core::Engine.routes.append do
  namespace :admin do
    resource :affiliate_settings, only: [:edit, :update]
  end

  resources :affiliates, only: [:show] do
    post :send_email, on: :member
  end
end
