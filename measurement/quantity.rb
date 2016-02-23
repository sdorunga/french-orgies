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
    self.amount == amount_of(other)
  end

  def +(other)
    self.class.new(self.amount + amount_of(other), self.unit)
  end

  private

  def amount_of(other)
    other.amount * other.unit.ratio(self.unit)
  end
end

class Numeric
  Unit.constants.each do |unit|
    define_method(unit.downcase) do
      Quantity.new(self, Unit.const_get(unit))
    end
  end
end
