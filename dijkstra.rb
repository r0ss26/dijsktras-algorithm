class Node
  attr_accessor :name, :edges, :minimum_distance, :visited

  def initialize(name, edges={}, minimum_distance=Float::INFINITY, visited=false)
    @name = name
    @edges = edges
    @minimum_distance = minimum_distance
    @visited = visited
  end

  def to_s
    puts "Node: #{@name}, Edges: #{@edges}, Minimum Distance: #{@minimum_distance}, Visited: #{@visited}"
  end
end

class Dijkstra

  # Takes a ruby hash representation of a graph and returns
  # a hash of node objects.
  def self.hash_to_nodes(graph)
    graph_nodes = {}

    graph.each do |name, edges_object|
      node = Node.new(name, edges_object)
      graph_nodes[name] = node
    end

    return graph_nodes
  end

  def self.dijkstra(graph, start_node, end_node)
    nodes = hash_to_nodes(graph)

    puts start_node
  end
end


test_graph = {'A'=> { 'B'=> 2, 'C'=> 7 }, 'B'=> { 'D'=> 1, 'E'=> 8 }, 'C'=> { 'B'=> 3, 'E'=> 12 }, 'D'=> { 'E'=> 4, 'F'=> 9 }, 'E'=> { 'F'=> 4 }, 'F'=> {} }
Dijkstra.dijkstra(test_graph, 'A', 'F')