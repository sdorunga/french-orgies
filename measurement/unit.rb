# Understands the scale of measurements
class Unit
  attr_reader :mass
  protected :mass

  def initialize(mass)
    @mass = mass
  end

  TEASPOON   = Unit.new(1)
  TABLESPOON = Unit.new(3)
  OUNCE      = Unit.new(6)
  CUP        = Unit.new(48)
  PINT       = Unit.new(96)
  QUART      = Unit.new(192)
  GALLON     = Unit.new(768)

  def ratio(other)
    self.mass.to_f / other.mass
  end
end
