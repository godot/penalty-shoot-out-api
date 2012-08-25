require 'spec_helper'

describe Game do
  let(:player) { User.new("josh") }

  subject { Game.new('PenaltyShootOut', player)}

  it { should respond_to :players }

  its(:turns) { should have(Game::TURN_LIMIT).rounds }

  it ' has turns properly named ' do
    subject.turns.map(&:type).uniq.should == Game::TURN_TYPES
  end

  its(:result) { should have_key(:winner) }

  it ' playing the game' do
    turn = subject.next_turn
    turn.should == subject.turns.first
    turn.update([1,2])

    turn2 = subject.next_turn
    turn.should_not == turn2
  end

  it ' playing the game' do
    turn = subject.next_turn
    turn.should == subject.turns.first
    turn.update([1,2])

    turn2 = subject.next_turn
    turn.should_not == turn2
  end

  describe Game::Turn do
    subject {Game::Turn.new }
    it { should_not be_completed }

    it ' turn ' do
      turn = Game::Turn.new

      expect{
        turn.result
      }.to raise_error('round_incomplete')

      turn.update([0,1])
      turn.result.should be_false

      turn.update([0,0])
      turn.result.should be_true

      turn.update([1,1])
      turn.result.should be_true

      turn.update([1,nil])
      turn.result.should be_false
    end
  end
end
