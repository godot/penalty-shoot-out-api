class Game
  attr_accessor :name, :players
  attr_accessor :turns
  attr_accessor :current_turn

  TURN_LIMIT = 10
  TURN_TYPES = [:shoot, :save]
  CHOISES = (0..15).to_a

  def initialize(name, player, player2 = User::CPlayer.new("computer"))
    @name = name
    @players = [player, player2].shuffle
    @turns = Array.new(TURN_LIMIT).fill {|i| Turn.new(TURN_TYPES[i%2]) }
  end

  def process
    return result if finished?
  end

  def next_turn
    turns.each do |turn|
      return turn unless turn.completed?
    end
  end

  def finished?
    turns.each do |turn|
      return unless turn.completed?
    end
  end

  def result
    {
      winner: players.sample,
      turns: turns
    }
  end


  def to_param
    self.name
  end

  class Turn
    attr_accessor :choises
    attr_accessor :type
    def initialize(type = :none)
      @type = type
      @choises = Array.new(2)
    end

    def update(values)
      @choises = values
    end

    def completed?
      @choises.any?
    end

    def result
      raise 'round_incomplete' unless completed?
      @choises[0] == @choises[1]
    end
  end
end
