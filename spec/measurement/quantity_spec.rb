require './measurement/unit'
require './measurement/quantity'

#Confirms behaviour of Quantity
RSpec.describe "Quantity" do
  it "is equal to other quantities" do
    expect(6.teaspoon).to eq(6.teaspoon)
    expect(6.teaspoon).to eq(2.tablespoon)
    expect(768.teaspoon).to eq(1.gallon)
  end

  it "is equal to other length quantities" do
    expect(1.foot).to eq(12.inch)
    expect(3.foot).to eq(1.yard)
    expect(1780.yard).to eq(1.mile)
    expect(1.inch).to_not eq(1.teaspoon)
  end

  it "can be added to other lengths" do
    expect(1.foot + 2.foot).to eq(1.yard)
    expect(12.inch + 2.foot + 1779.yard).to eq(1.mile)
  end

  it "can be compared to other temperatures" do
    expect(0.celsius).to eq(32.fahrenheit)
    expect(32.fahrenheit).to eq(0.celsius)
    expect(10.celsius).to eq(50.fahrenheit)
    expect(50.fahrenheit).to eq(10.celsius)
    expect(100.celsius).to eq(212.fahrenheit)
    expect(212.fahrenheit).to eq(100.celsius)
    expect(-40.celsius).to eq(-40.fahrenheit)
    expect(-40.fahrenheit).to eq(-40.celsius)
    expect(0.kelvin).to eq(-273.15.celsius)
    expect(-273.15.celsius).to eq(0.kelvin)
    expect(0.kelvin).to eq(-459.67.fahrenheit)
  end

  it "can not add inconsistent units" do
    expect{1.foot + 1.ounce}.to raise_error("Incompatible types")
  end

  it "can be added to other quantities" do
    expect(1.teaspoon + 2.teaspoon).to eq(1.tablespoon)
    expect(3.teaspoon + 1.tablespoon).to eq(2.tablespoon)
    expect(3.teaspoon + 1.tablespoon + 7.ounce + 1.cup + 1.pint + 3.quart).to eq(1.gallon)
    expect{50.fahrenheit + 0.celsius}.to raise_error(NoMethodError)
    expect{10.celsius + 10.celsius}.to raise_error(NoMethodError)
  end
end
