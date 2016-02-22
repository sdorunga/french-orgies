#Understands the chance of an event occuring
class Probability
  CERTAINTY_RATIO = 1

  attr_reader :ratio

  protected :ratio

  def initialize(ratio)
    raise ArgumentError.new("Ratio must be between 0 and 1") unless (0..CERTAINTY_RATIO).cover?(ratio)
    @ratio = ratio
  end

  def not
    build(CERTAINTY_RATIO - ratio)
  end

  def and(other)
    build(self.ratio * other.ratio)
  end

  def or(other)
    #other.not.and(self.not).not
    build(self.ratio + other.ratio - self.and(other).ratio)
  end

  def ==(other)
    other.ratio == self.ratio
  end

  private

  def build(ratio)
    self.class.new(ratio)
  end
end
