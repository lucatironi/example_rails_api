Rails.application.routes.draw do
  resource  :sessions,  only: [:create, :destroy]
  resources :customers, only: [:index, :show, :create, :update, :destroy]
end
