require 'spec_helper'
require './rectangle/rectangle'

RSpec.describe Rectangle do
  subject(:rectangle) { described_class.new(width: 10, height: 5) }
  it "has a width" do
    expect(rectangle.width).to eq(10)
  end

  it "has a height" do
    expect(rectangle.height).to eq(5)
  end

  it "has four sides" do
    expect(rectangle.number_of_sides).to eq(4)
  end

  it "knows its perimeter" do
    expect(rectangle.perimeter).to eq(30)
  end

  it "knows its area" do
    expect(rectangle.area).to eq(50)
  end

  it "knows the sum of its angles" do
    expect(rectangle.sum_of_interior_angles).to eq(360)
  end
end
