#Understands the relative values of different cooking measurements
class Measurement
  attr_reader :base_value, :unit, :quantity
  protected :base_value, :unit, :quantity

  CONVERSIONS = {
    teaspoon: 1,
    tablespoon: 3,
    ounce: 6,
    cup: 48,
    pint: 96,
    quart: 192,
    gallon: 768
  }

  def initialize(quantity, unit)
    @unit = unit
    @quantity = quantity
  end

  def +(other)
    self.class.new(self.quantity + other.in(unit), unit)
  end

  def -(other)
    self.class.new(self.quantity - other.in(unit), unit)
  end

  def *(times)
    self.class.new(self.quantity * times, unit)
  end

  def ==(other)
    self.base_value == other.base_value
  end

  protected

  def base_value
    CONVERSIONS[unit] * quantity
  end

  def in(unit)
    base_value.to_f / CONVERSIONS[unit]
  end
end
