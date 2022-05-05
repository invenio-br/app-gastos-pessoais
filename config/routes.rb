Rails.application.routes.draw do
  devise_for :usuarios
  resources :movimentacoes, only: [:index, :new, :create, :destroy]

  root "movimentacoes#index"
end
