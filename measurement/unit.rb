require './measurement/quantity'
# Understands the scale of measurements
class Unit
  class BaseUnit
    attr_reader :quantity_type

    def initialize(quantity_type)
      @quantity_type = quantity_type
    end

    def base_value
      1.0
    end
    def base_unit
      self
    end
  end

  attr_reader :base_value, :base_unit, :offset
  protected :base_value, :base_unit

  def initialize(label, unit_count, unit, offset = 0)
    @base_value = unit_count * unit.base_value
    @base_unit = unit.base_unit
    @offset = offset
    create_numeric_builder(label, @base_unit.quantity_type)
  end

  def converted_amount(amount, other)
    raise "Incompatible types" unless comparable?(other)
    (amount - other.offset) * other.base_value / self.base_value + self.offset
  end

  def comparable?(other)
    other.base_unit == self.base_unit
  end

  private

  def create_numeric_builder(label, quantity_type)
    unit = self
    Numeric.class_eval do
      define_method label.to_s do
        quantity_type.new(self, unit)
      end
    end
  end

  INCH       = Unit.new(:inch, 1, BaseUnit.new(RatioQuantity))
  FOOT       = Unit.new(:foot, 12, INCH)
  YARD       = Unit.new(:yard, 3, FOOT)
  MILE       = Unit.new(:mile, 1780, YARD)

  TEASPOON   = Unit.new(:teaspoon, 1, BaseUnit.new(RatioQuantity))
  TABLESPOON = Unit.new(:tablespoon, 3, TEASPOON)
  OUNCE      = Unit.new(:ounce, 2, TABLESPOON )
  CUP        = Unit.new(:cup, 8, OUNCE)
  PINT       = Unit.new(:pint, 2, CUP)
  QUART      = Unit.new(:quart, 2, PINT)
  GALLON     = Unit.new(:gallon, 4, QUART)

  CELSIUS    = Unit.new(:celsius, 1, BaseUnit.new(IntervalQuantity))
  FAHRENHEIT = Unit.new(:fahrenheit, 5/9.0, CELSIUS, 32)
  KELVIN     = Unit.new(:kelvin, 1, CELSIUS, 273.15)
end

