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

  # Calculates the minimum distance between a node and a neighbouring node.
  def self.calculate_neighbouring_node_minimum_distance(current_node, neighbour_node)
    distance_from_current_node = current_node.edges[neighbour_node.name]
    new_distance = current_node.minimum_distance + distance_from_current_node 
    if new_distance < neighbour_node.minimum_distance
      return new_distance
    end
    return neighbour_node.minimum_distance
  end

  # Finds the unvisited node with the smallest minimum distance from a hash of nodes.
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

  def self.calculate_all_neighours_minimum_distance(nodes_hash, current_node)
   current_node.edges.each do |node_name, distance|
      neighbour_node = nodes_hash[node_name]
      neighbour_node.minimum_distance = calculate_neighbouring_node_minimum_distance(current_node, neighbour_node)
    end
    current_node.visited = true
    return nodes_hash
  end


  def self.dijkstra(graph, start_node, end_node)
    nodes = hash_to_nodes(graph)
    
    start_node = nodes[start_node]
    start_node.minimum_distance = 0
    
    # calculate the minimum distance for all nodes in the graph
    current_node = start_node
    visited_count = 0
    while visited_count < nodes.keys.length
      nodes = calculate_all_neighours_minimum_distance(nodes, current_node)
      current_node.visited = true
      current_node = select_next_current_node(nodes)
      visited_count += 1
    end

    puts start_node
  end
end


test_graph = {'A'=> { 'B'=> 2, 'C'=> 7 }, 'B'=> { 'D'=> 1, 'E'=> 8 }, 'C'=> { 'B'=> 3, 'E'=> 12 }, 'D'=> { 'E'=> 4, 'F'=> 9 }, 'E'=> { 'F'=> 4 }, 'F'=> {} }
Dijkstra.dijkstra(test_graph, 'A', 'F')