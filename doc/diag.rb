require 'graphviz/dsl'
digraph :G do
  root[:label => "/penalty-shoot-out-api-access-point"]

  root<< games[:label => "/games"]
  root << halloffame[:label => "hall-of-fame"]

  games << game[:label => "/games/1"]
  game << turns[:label => "/games/1/turns"]

  turns << turn[:label => "/games/1/turns/1"]
  
  turn << actions[:label => "/games/1/turns/1/choises"]
  actions << action[:label => "/games/1/turns/1/choises/1"]
  
  output :png => "penalty-shoot-out-api.png"
end
