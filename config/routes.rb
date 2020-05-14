Rails.application.routes.draw do
  resources :repositories, only: :index
end
