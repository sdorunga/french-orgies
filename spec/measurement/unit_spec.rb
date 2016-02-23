require './measurement/unit'

#Confirms behaviour of Unit
RSpec.describe Unit do
  it "understands its ratio to other units" do
    expect(Unit::TEASPOON.ratio(Unit::TABLESPOON)).to eq(1.0 / 3)
    expect{Unit::TABLESPOON.ratio(Unit::FOOT)}.to raise_error("Incompatible types")
  end
end
