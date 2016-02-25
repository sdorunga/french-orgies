# Understands if it can reach other locations on the graph

class Node
  attr_reader :neighbours, :edges
  protected :neighbours, :edges

  UNREACHABLE = Float::INFINITY
  def initialize
    @neighbours = []
    @edges = []
  end

  def link(target, weight)
    neighbours << target
    edges << Edge.new(target, weight)
  end

  def reach?(destination, visited_neighbours = [])
    sum(destination, Edge::FEWEST_HOPS) != UNREACHABLE
  end

  def cost(destination)
    handle_unreachable(sum(destination, Edge::LOWEST_COST))
  end

  def hop_count(destination)
    handle_unreachable(sum(destination, Edge::FEWEST_HOPS))
  end

  def sum(destination, avoiding_edges=[], strategy)
    return 0 if self == destination

    (edges - avoiding_edges).map do |edge|
      edge.sum(destination, avoiding_edges.dup << edge, strategy)
    end.min || UNREACHABLE
  end

  private

  def handle_unreachable(result)
    raise "Unreachable destination" if result == UNREACHABLE
    result
  end
end

class Edge
  FEWEST_HOPS = ->(weight) { 1 }
  LOWEST_COST = ->(weight) { weight }

  def initialize(finish, weight)
    @weight = weight
    @finish = finish
  end

  def sum(destination, avoiding_edges, strategy)
    @finish.sum(destination, avoiding_edges, strategy) + strategy.call(weight)
  end

  private

  attr_reader :weight

  def hops
    1
  end
end
