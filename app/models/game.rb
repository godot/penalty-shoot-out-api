class Game
  attr_accessor :name, :users
  attr_accessor :turns

  TURN_LIMIT = 10

  def initialize(name)
    @name = name
    @users = []
    @turns = Array.new(TURN_LIMIT).fill(Turn.new)
  end

  def process
    raise 'missing_player' if self.missing_player?
  end

  def missing_player?
    self.users.size < 2
  end

  def to_param
    self.name
  end

  def finished?
    false
  end

  class Turn
    attr_accessor :choises
    def initialize
      @choises = [Choise.new,Choise.new]
    end

    def completed?
      @choises.map(&:done?) == [true,true]
    end

    def result
      raise 'round_incomplete' unless completed?

      @choises[0] == @choises[1]
    end
  end

  class Choise
    VALUES = (0..15).to_a
    attr_accessor :value

    def done?
      !!value
    end

    def ==(other)
      self.value == other.value
    end
  end
end
