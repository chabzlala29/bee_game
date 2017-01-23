Rails.application.routes.draw do
  # Using the resources-only principle to have a well-structured readable routes

  resources :game, controller: "game", only: [:index]
  resource :hit_bee, controller: "hit_bee", only: [:create]

  root to: "game#index"
end
