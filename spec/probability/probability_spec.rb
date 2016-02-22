require 'spec_helper'
require './probability/probability'

RSpec.describe Probability do
  subject(:probability) { described_class.new(0.6) }
  
  it "doesn't accept ratios grater than 1"do
    expect { described_class.new(1.1) }.to raise_error(ArgumentError)
  end

  it "doesn't accept ratios lower than 0"do
    expect { described_class.new(-0.1) }.to raise_error(ArgumentError)
  end

  it "gives the probablity of an event not happening" do
    expected_probability = described_class.new(0.4)
    expect(subject.not).to eq(expected_probability)
  end

  it "gives the probablity of both events happening" do
    other_probability = described_class.new(0.5)

    expected_probability = described_class.new(0.3)
    expect(subject.and(other_probability)).to eq(expected_probability)
  end

  it "gives the probablity with an impossible event" do
    impossible_probability = described_class.new(0)

    expect(subject.and(impossible_probability)).to eq(impossible_probability)
  end

  it "gives the probablity of either events happening" do
    other_probability = described_class.new(0.5)

    expected_probability = described_class.new(0.8)
    expect(subject.or(other_probability)).to eq(expected_probability)
  end
end
