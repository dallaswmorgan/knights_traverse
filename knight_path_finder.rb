require_relative '00_tree_node.rb'

class KnightPathFinder
  attr_reader :position
  attr_accessor :visited_positions

  def initialize(position = [0, 0])
    @position = position
    @visited_positions = [position]
    @root = PolyTreeNode.new(position)
    build_move_tree
  end

  def new_move_positions(pos)
    potential_positions = valid_moves(pos)
    @visited_positions.each do |position|
      potential_positions.delete(position)
    end
    @visited_positions += potential_positions
    potential_positions
  end


  # (0..7).to_a.each do |row|
  #   (0..7).to_a.each do |col|
  #     PolyTreeNode.new([row, col])
  #   end
  # end
  def build_move_tree
    # root = PolyTreeNode.new(@position)
    queue = [@root]
    until queue.empty?
      current = queue.shift
      # return current if current.position == target_pos
      new_move_positions(current.value).each do |pos|
        node = PolyTreeNode.new(pos)
        node.parent = current
        queue << node

      end
      nil
      # p root.bfs([1,2])
    end
    nil
  end

  def find_path(end_pos)
  end_node = @root.bfs(end_pos)
  trace_path_back(end_node)
  end

  def trace_path_back(node)
    path = []
    until node.nil?
      path << node.value
      node = node.parent
    end
    path.reverse!
  end

  # new_move_positions(@position).each do |pos|
  #   current_pos = PolyTreeNode.new(pos)
  #   current_pos.parent = root
  # end

  def self.valid_moves(position)
    potential_moves(position).select { |move| is_valid_pos?(move) }
  end

  def self.potential_moves(pos)
    row = pos.first
    col = pos.last
    positions = []
    positions << [(row - 2), (col - 1)]
    positions << [(row - 2), (col + 1)]
    positions << [(row - 1), (col - 2)]
    positions << [(row - 1), (col + 2)]
    positions << [(row + 1), (col - 2)]
    positions << [(row + 1), (col + 2)]
    positions << [(row + 2), (col - 1)]
    positions << [(row + 2), (col + 1)]
    positions
  end

  def self.is_valid_pos?(pos)
    row = pos.first
    col = pos.last
    return false if row > 7 || col > 7 || row < 0 || col < 0

    true
  end

end
