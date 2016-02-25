require "./graph/node"

describe Node do
  let(:a) { described_class.new }
  let(:b) { described_class.new }
  let(:c) { described_class.new }
  let(:d) { described_class.new }
  let(:e) { described_class.new }
  let(:f) { described_class.new }
  let(:g) { described_class.new }
  let(:h) { described_class.new }

  before do
    b.link(f, 8)
    b.link(c, 4)
    b.link(a, 7)

    c.link(d, 1)
    d.link(e, 2)
    c.link(d, 5)
    c.link(e, 6)

    e.link(b, 3)

    f.link(h, 9)
  end

  it "can tell if a node can be reached from another node" do
    expect(b.reach?(f)).to be true
    expect(b.reach?(g)).to be false
    expect(b.reach?(e)).to be true
    expect(b.reach?(d)).to be true
    expect(b.reach?(b)).to be true
    expect(c.reach?(f)).to be true
    expect(d.reach?(a)).to be true
    expect(a.reach?(e)).to be false
    expect(c.reach?(a)).to be true
    expect(a.reach?(a)).to be true
  end

  it "can count how many hops it needed to find a node" do
    expect(b.hop_count(b)).to eq(0)
    expect(b.hop_count(c)).to eq(1)
    expect(b.hop_count(e)).to eq(2)
    expect(c.hop_count(f)).to eq(3)
    expect(c.hop_count(h)).to eq(4)
    expect(b.hop_count(h)).to eq(2)
    expect(c.hop_count(d)).to eq(1)
    expect{a.hop_count(b)}.to raise_error("Unreachable destination")
    expect{c.hop_count(g)}.to raise_error("Unreachable destination")
  end

  it "can calculate cost" do
    expect(b.cost(c)).to eq(4)
    expect(b.cost(a)).to eq(7)
    expect(b.cost(b)).to eq(0)
    expect{b.cost(g)}.to raise_error("Unreachable destination")
    expect(b.cost(h)).to eq(17)
    expect(b.cost(e)).to eq(7)
  end
end
