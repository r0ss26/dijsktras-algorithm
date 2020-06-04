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

# Implements the dijkstra algorithm and related helper methods.
class Dijkstra

  # Takes a hash representation of a graph and returns
  # a hash of node objects.
  def self.hash_to_nodes(graph)
    graph_nodes = {}

    graph.each do |node_name, edges_object|
      node = Node.new(node_name, edges_object)
      graph_nodes[node_name] = node
    end

    return graph_nodes
  end

  # Calculates the minimum distance between a current node and a neighbour node.
  def self.calculate_neighbouring_node_minimum_distance(current_node, neighbour_node)
    distance_from_current_node = current_node.edges[neighbour_node.name]
    new_distance = current_node.minimum_distance + distance_from_current_node 
    if new_distance < neighbour_node.minimum_distance
      return new_distance
    end
    return neighbour_node.minimum_distance
  end

  # Finds the unvisited node with the smallest minimum distance.
  def self.select_next_current_node(nodes)
    smallest_unvisited_node = nil
    nodes.each do |node_name, node|
      if !node.visited
        if smallest_unvisited_node == nil || node.minimum_distance < smallest_unvisited_node.minimum_distance
          smallest_unvisited_node = node
        end
      end
    end
    return smallest_unvisited_node
  end

  # Calculates the minimum distances for all of a nodes neighbours.
  def self.calculate_all_neighours_minimum_distance(nodes_hash, current_node)
   current_node.edges.each do |node_name, distance|
      neighbour_node = nodes_hash[node_name]
      neighbour_node.minimum_distance = calculate_neighbouring_node_minimum_distance(current_node, neighbour_node)
    end
    
    return nodes_hash
  end

  # The dijkstra algorithm for calculating the shortest path between two nodes.
  def self.dijkstra(graph, start_node, end_node)
    nodes = hash_to_nodes(graph)
    
    # Configure the starting node.
    start_node = nodes[start_node]
    start_node.minimum_distance = 0
    start_node.path.push(start_node.name)
    
    # Calculate the minimum distance for all nodes in the graph
    current_node = start_node
    visited_count = 0
    while visited_count < nodes.keys.length - 1
      nodes = calculate_all_neighours_minimum_distance(nodes, current_node)
      current_node.visited = true
      current_node = select_next_current_node(nodes)
      visited_count += 1
    end

    puts start_node
  end
end

# Example graph
test_graph = {'A'=> { 'B'=> 2, 'C'=> 7 }, 'B'=> { 'D'=> 1, 'E'=> 8 }, 'C'=> { 'B'=> 3, 'E'=> 12 }, 'D'=> { 'E'=> 4, 'F'=> 9 }, 'E'=> { 'F'=> 4 }, 'F'=> {} }

# Returns {:distance => 11, :path => ["A", "B", "D", "E", "F"]}
p Dijkstra.dijkstra(test_graph, 'A', 'F')