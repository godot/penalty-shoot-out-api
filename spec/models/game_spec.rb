require 'spec_helper'

describe Game do
  let(:player) { User.new("josh") }

  subject { Game.new('PenaltyShootOut', player)}

  it { should respond_to :players }

  its(:turns) { should have(Game::TURN_LIMIT).rounds }

  it ' has turns properly named ' do
    subject.turns.map(&:type).uniq.should == Game::TURN_TYPES
  end

  it ' playing the game' do
    turn = subject.next_turn
    turn.should == subject.turns.first
    turn.update([1,2])

    turn2 = subject.next_turn
    turn.should_not == turn2
  end

  it ' playing the game ' do

    10.times do |i|
      turn = subject.next_turn
      turn.update([1,2])
    end

    subject.next_turn.tap do |turn|
      turn.type.should_not == :final_result
      turn.update([10,0])
    end

    subject.next_turn.type.should == :final_result

  end

  describe Game::Turn do
    subject {Game::Turn.new }
    it { should_not be_completed }

    it ' turn ' do
      turn = Game::Turn.new

      turn.result.should == :pending

      turn.update([1,1])
      turn.result.should == 0

      turn.update([12,1])
      turn.result.should == 1

    end
  end
end
