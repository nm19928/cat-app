Rails.application.routes.draw do
  resources :cat do
    resources :cat_rental
  end

  resources :cat_rental do
    member do
      post :approved
    end
  end

  resources :user

  resources :sessions
end
