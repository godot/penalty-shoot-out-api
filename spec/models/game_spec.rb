require 'spec_helper'

describe Game do

  subject { Game.new('PenaltyShootOut')}

  it { should respond_to :users }

  it ' raises error if missing player ' do
    expect {
      subject.process
    }.to raise_error('missing_player')
  end


end
