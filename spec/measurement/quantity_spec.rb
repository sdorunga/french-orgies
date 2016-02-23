require './measurement/quantity'
require './measurement/unit'

#Confirms behaviour of Quantity
RSpec.describe Quantity do
  it "is equal to other quantities" do
    expect(6.teaspoon).to eq(Quantity.new(6, Unit::TEASPOON))
    expect(6.teaspoon).to eq(6.teaspoon)
    expect(6.teaspoon).to eq(2.tablespoon)
    expect(768.teaspoon).to eq(1.gallon)
  end

  it "can be added to other quantities" do
    expect(1.teaspoon + 2.teaspoon).to eq(1.tablespoon)
    expect(3.teaspoon + 1.tablespoon).to eq(2.tablespoon)
    expect(3.teaspoon + 1.tablespoon + 7.ounce + 1.cup + 1.pint + 3.quart).to eq(1.gallon)
  end
end
