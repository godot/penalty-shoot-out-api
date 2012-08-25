class Game
  extend ActiveModel::Naming
  attr_accessor :name, :players
  attr_accessor :turns

  TURN_LIMIT = 10
  TURN_TYPES = [:shoot, :save]
  CHOISES = (0..14).to_a

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
    report_or_next_turn
  end

  def finished?
    turns.each do |turn|
      return unless turn.completed?
    end
  end

  def report_or_next_turn
    if result.uniq.size == 1
      Turn.new(TURN_TYPES[@turns.size%2]).tap do |turn|
        self.turns << turn
      end
    else
      Turn.new(:final_result).tap do |report|
        report.update(result)
      end
    end
  end

  def result()
    [0,0].tap do |final_result|
      turns.each_with_index do |turn,idx|
        final_result[idx%2] += turn.result
        return final_result if (final_result[0] - final_result[1]).abs == 3
      end
    end
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
      return :pending unless completed?
      @choises[0] == @choises[1] ? 0 : 1
    end
  end

  class FinalResult < Turn
    
  end
end
