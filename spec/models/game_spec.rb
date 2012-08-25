require 'spec_helper'

describe Game do

  subject { Game.new('PenaltyShootOut')}

  it { should respond_to :users }

  it ' raises error if missing player ' do
    expect {
      subject.process
    }.to raise_error('missing_player')
  end

  context ' new game state ' do
    its(:turns) { should have(Game::TURN_LIMIT).rounds }
  end

  describe Game::Turn do
    it ' is incomplete after init' do
      Game::Turn.new.should_not be_completed
    end
    it ' turn ' do
      turn = Game::Turn.new

      expect{
        turn.result
      }.to raise_error('round_incomplete')

      turn.choises[0].value = 1
      turn.choises[1].value = 1
      turn.result.should be_true

      turn.choises[0].value = 2
      turn.choises[1].value = 5
      turn.result.should be_false

      turn.choises[0].value = 1
      turn.choises[1].value = 0
      turn.result.should be_false

    end
  end
end
