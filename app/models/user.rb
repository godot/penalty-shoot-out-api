class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_param
    self.name
  end
end
