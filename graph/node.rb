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


  def path(destination)
    handle_unreachable(pick(destination))
  end

  def pick(destination, avoiding_edges=[])
    return Path.new if self == destination

    (edges - avoiding_edges).map do |edge|
      edge.pick(destination, avoiding_edges.dup << edge)
    end.min_by(&:cost) || Path.new
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
  attr_reader :weight

  FEWEST_HOPS = ->(weight) { 1 }
  LOWEST_COST = ->(weight) { weight }

  def initialize(finish, weight)
    @weight = weight
    @finish = finish
  end

  def sum(destination, avoiding_edges, strategy)
    @finish.sum(destination, avoiding_edges, strategy) + strategy.call(weight)
  end

  def pick(destination, avoiding_edges)
    @finish.pick(destination, avoiding_edges).add_edge(self, @weight)
  end

  def self.total_cost(edges)
    edges.map(&:weight).reduce(&:+)
  end

  private

  def hops
    1
  end
end

class Path
  def initialize
    @edges = []
    @cost = 0
  end

  def add_edge(edge, cost)
    @edges << edge
    @cost += cost
    self
  end

  def length
    @edges.length
  end

  def cost
    @cost
  end
end
