# Understands if it can reach other locations on the graph

class Node
  def initialize
    @neighbours = []
  end

  def link(node)
    neighbours << node
  end

  def reach?(destination, visited_neighbours = [])
    !!recursive_hop_count(destination, [], 0)
  end

  def hop_count(destination)
    result = recursive_hop_count(destination, [], 0)
    raise "Unreachable destination" unless result
    result
  end

  protected

  def recursive_hop_count(destination, used_starting_points, hops)
    return hops if self == destination
    return hops + 1 if self.neighbours.include?(destination)

    (neighbours - used_starting_points).flat_map do |neighbour|
      neighbour.recursive_hop_count(destination, (used_starting_points.dup << self), hops + 1)
    end.compact.min
  end

  attr_reader :neighbours
end
