# Understands if it can reach other locations on the graph

class Node
  UNREACHABLE = Float::INFINITY
  def initialize
    @neighbours = []
    @edges = []
  end

  def link(node, weight)
    neighbours << node
    edges << Edge.new(self, node, weight)
  end

  def reach?(destination, visited_neighbours = [])
    recursive_hop_count(destination) != UNREACHABLE
  end

  def hop_count(destination)
    result = recursive_hop_count(destination)
    raise "Unreachable destination" if result == UNREACHABLE
    result
  end

  def cost(destination)
    result = recursive_cost(destination)
    raise "Unreachable destination" if result == UNREACHABLE
    result
  end

  protected

  def recursive_cost(destination, used_starting_points=[])
    return 0 if self == destination

    (neighbours - used_starting_points).flat_map do |neighbour|
      neighbour.recursive_cost(destination, used_starting_points.dup << self) + edges.map { |edge| edge.cost_to(neighbour) }.min
    end.compact.min || UNREACHABLE
  end

  def recursive_hop_count(destination, used_starting_points = [])
    return 0 if self == destination

    (neighbours - used_starting_points).flat_map do |neighbour|
      neighbour.recursive_hop_count(destination, (used_starting_points.dup << self)) + 1
    end.compact.min || UNREACHABLE
  end

  attr_reader :neighbours, :edges
end

class Edge

  def initialize(start, finish, weight)
    @weight = weight
    @finish = finish
    @start = start
  end

  def cost_to(node)
    return 0 if node == @start
    return @weight if node == @finish
    Node::UNREACHABLE
  end
end
