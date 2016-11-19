class PolyTreeNode
  attr_accessor :parent,:children, :old_parent
  attr_reader :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
    @old_parent = nil
  end

  def parent=(par)
    return if par == @parent
    @parent.children.delete(self) unless @parent.nil?
    @parent = par
    if @parent.nil?
      return
    else
      @parent.children << self unless @parent.children.include? self
    end
  end


  def add_child(child_node)
    return if @children.include? child_node
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child)
    return if child == nil
    raise "Cannot remove child" unless self.children.include? child

    child.parent = nil
  end

  def dfs(value)
    return self if @value == value

    @children.each do |child|
      node = child.dfs(value)
      return node unless node.nil?
    end
    nil
  end

  def bfs(value)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == value
      current.children.each { |child| queue << child }
    end
    nil
  end
end
