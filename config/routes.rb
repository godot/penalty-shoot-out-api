PenaltyShootOutApi::Application.routes.draw do
  get "welcome/index"

  get "games/index"
  get "games/create"
  get "games/:id" => "games#show", :as => :game
  get "games/:id/:choise" => "games#perform", :as => :play

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'welcome#index'
end
