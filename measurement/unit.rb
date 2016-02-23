# Understands the scale of measurements
class Unit
  class BaseUnit; def base_value; 1.0; end; def base_unit; self; end; end

  attr_reader :base_value, :base_unit, :starting_point
  protected :base_value, :base_unit

  def initialize(unit_count, unit, starting_point = 0)
    @base_value = unit_count * unit.base_value
    @base_unit = unit.base_unit
    @starting_point = starting_point
  end

  def ratio(other)
    raise "Incompatible types" unless comparable?(other)

    self.base_value / other.base_value
  end

  def comparable?(other)
    other.base_unit == self.base_unit
  end

  CELSIUS    = Unit.new(1, BaseUnit.new)
  FAHRENHEIT = Unit.new(5/9.0, CELSIUS, 32)

  INCH       = Unit.new(1, BaseUnit.new)
  FOOT       = Unit.new(12, INCH)
  YARD       = Unit.new(3, FOOT)
  MILE       = Unit.new(1780, YARD)

  TEASPOON   = Unit.new(1, BaseUnit.new)
  TABLESPOON = Unit.new(3, TEASPOON)
  OUNCE      = Unit.new(2, TABLESPOON)
  CUP        = Unit.new(8, OUNCE)
  PINT       = Unit.new(2, CUP)
  QUART      = Unit.new(2, PINT)
  GALLON     = Unit.new(4, QUART)
end
