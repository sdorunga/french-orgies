require './measurement/unit'

#Confirms behaviour of Unit
RSpec.describe Unit do
  it "understands its ratio to other units" do
    expect(Unit::TEASPOON.converted_amount(1, Unit::TABLESPOON)).to eq(3)
    expect{Unit::TABLESPOON.converted_amount(1, Unit::FOOT)}.to raise_error("Incompatible types")
  end
end
