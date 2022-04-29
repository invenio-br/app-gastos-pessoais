Rails.application.routes.draw do
  resources :movimentacoes, only: [:index, :new, :create, :destroy]

  root "movimentacoes#index"
end
