Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit]

  resources :pictures do
      collection do
          post :confirm
      end
  end
  root to: 'pictures#index'
end
