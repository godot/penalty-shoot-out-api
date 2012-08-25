PenaltyShootOutApi::Application.routes.draw do
  get "welcome/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'welcome#index'
end
