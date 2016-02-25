# Understands if it can reach other locations on the graph

class Node
  def initialize
    @neighbours = []
  end

  def link(node)
    neighbours << node
  end

  def reach?(node, visited_neighbours = [])
    return true if node == self

    neighbours.any? do |neighbour|
      next if visited_neighbours.include? neighbour
      neighbour.reach? node, (visited_neighbours << neighbour)
    end
  end

  def hop_count(node)
    hops = recursive_hop_count(node, [self], 0)
    raise "Unreachable node" if hops.empty?
    hops.min
  end

  protected

  def recursive_hop_count(node, used_starting_points, hops)
    return [hops] if self == node
    return [hops + 1] if self.neighbours.include?(node)

    (neighbours - used_starting_points).flat_map do |neighbour|
      neighbour.recursive_hop_count(node, (used_starting_points.dup << self), hops + 1)
    end
  end

  attr_reader :neighbours
end
