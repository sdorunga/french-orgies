require './measurement/measurement'

# Makes sure that the Measurement class is correct
RSpec.describe Measurement do

  subject(:measurement) { described_class.new(1, :gallon)}

  it "can add two measures together" do
    gallon = described_class.new(1, :gallon)
    two_quarts = described_class.new(2, :quart)
    expect(two_quarts + two_quarts).to eq(gallon)
  end

  it "can subtract two measures" do
    gallon = described_class.new(1, :gallon)
    two_quarts = described_class.new(2, :quart)
    half_gallon = described_class.new(0.5, :gallon)
    expect(gallon - two_quarts).to eq(two_quarts)
    expect(gallon - two_quarts).to eq(half_gallon)
  end

  it "can multiply a measure" do
    gallon = described_class.new(1, :gallon)
    three_gallons = described_class.new(3, :gallon)
    expect(gallon * 3).to eq(three_gallons)
  end

end
