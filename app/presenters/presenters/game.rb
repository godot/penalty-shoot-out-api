module Presenters
  class Game
    include Roar::Representer::JSON::HAL
    include Roar::Representer::Feature::Hypermedia

    attr_accessor :params
    def initialize(params)
      @params = params
    end
    #links
    link :self do
      game_url(game,url_params)
    end
    link :action do
      available_choises.map do |value|
        play_url(game, value)
      end unless current_turn.type == :final_result
    end

    property :players
    property :current_turn
    property :status
    property :available_choises


    def current_turn
      game.next_turn
    end

    def status
      game.turns.map do |turn|
        {turn.type => turn.choises}
      end
    end

    def players
      game.players
    end

    def game
      params[:game]
    end

    def available_choises
      game.class::CHOISES
    end

    private
    def url_params
      {
        format:params[:format],
        user:params[:user].to_param
      }
    end
  end
end
