class Game
  attr_accessor :name, :users

  def initialize(name)
    @name = name
    @users = []
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
end
