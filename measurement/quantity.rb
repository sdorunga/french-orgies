# Understands number of a specific metric
require './measurement/unit'

class Quantity
  attr_reader :amount, :unit
  protected :amount, :unit

  def initialize(amount, unit)
    @amount = amount
    @unit = unit
  end

  def ==(other)
    return false unless self.unit.comparable?(other.unit)

    (self.amount - amount_of(other)).abs < 0.00000001
  end

  def +(other)
    self.class.new(self.amount + amount_of(other), self.unit)
  end

  private

  def amount_of(other)
    unit.converted_amount(other.amount, other.unit)
  end
end

class Numeric
  Unit.constants.each do |unit|
    define_method(unit.downcase) do
      Quantity.new(self, Unit.const_get(unit))
    end
  end
end
