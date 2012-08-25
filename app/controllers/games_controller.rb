class GamesController < ApplicationController
  @@current_game = nil
  def self.current_game
    @@current_game
  end
  def self.current_game=(game)
    @@current_game = game
  end

  before_filter :check_game, except:[:create, :index]
  def perform
    turn = current_game.next_turn

    if turn.type == :final_result
      #redirect to final page
    else
      choises = current_game.players.map do |player|
        player.is_a?(User::CPlayer) ? player.pick(current_game.class::CHOISES) : params[:choise].to_i
      end
      turn.update(choises)
    end
    redirect_to current_game
  end

  def index
    render json: Index.new(format:'json',user:current_user)
  end

  def new
  end

  def create
    register(Game.new("PenaltyShootOut",current_user))
    redirect_to current_game
  end

  def show
    render json: Presenters::Game.new(format:'json',user:current_user,game:current_game)
  end

  private
  def register(game)
    self.class.current_game = game
  end
  def current_game
    self.class.current_game
  end
  def check_game
    redirect_to root_url if current_game.nil?
  end
end
