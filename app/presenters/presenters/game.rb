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
      choises.map do |value|
        play_url(game, value)
      end unless current_turn.type == :final_result
    end
    property :players
    property :current_turn
    property :status
    property :choises


    def current_turn
      game.next_turn
    end

    def status
      game.turns.map(&:result)
    end

    def players
      game.players
    end

    def game
      params[:game]
    end

    def choises
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
