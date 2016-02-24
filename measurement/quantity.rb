# Understands number of a specific metric
require './measurement/unit'

class IntervalQuantity
  EPSILON = 0.0000001
  attr_reader :amount, :unit
  protected :amount, :unit

  def initialize(amount, unit)
    @amount = amount
    @unit = unit
  end

  def ==(other)
    return false unless self.unit.comparable?(other.unit)

    (self.amount - converted_amount_of(other)).abs < EPSILON
  end

  private

  def converted_amount_of(other)
    unit.converted_amount(other.amount, other.unit)
  end
end

class RatioQuantity < IntervalQuantity
  def +(other)
    self.class.new(self.amount + converted_amount_of(other), self.unit)
  end
end
