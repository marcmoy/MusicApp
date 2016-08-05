Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums do
      resources :tracks
    end
  end

  root to: redirect("/bands")
end
