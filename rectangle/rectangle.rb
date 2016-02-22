class Rectangle
  NUMBER_OF_SIDES = 4

  attr_reader :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height
  end

  def perimeter
    (height + width) * 2
  end

  def area
    height * width
  end

  def sum_of_interior_angles
    (number_of_sides - 2) * 180
  end

  def number_of_sides
    NUMBER_OF_SIDES
  end
end
