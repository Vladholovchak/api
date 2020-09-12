Rails.application.routes.draw do

  get 'articles/index'
  resources :articles, only: [:index, :show]

end
