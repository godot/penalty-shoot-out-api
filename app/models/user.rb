class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_param
    self.name
  end

  class CPlayer < User
    def pick(choises)
      choises.sample
    end
  end
end
