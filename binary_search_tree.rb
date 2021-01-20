class Node
  attr_accessor :data, :left_children, :right_children
    
  def initialize(data = nil, left = nil, right = nil  )
      @data = data
      @left_children = left
      @right_children = right
  end
    
end

class Tree
  attr_accessor :root, :ary
    
  def initialize(ary)
    @ary = ary
    @ary = @ary.sort
    @ary = @ary.uniq

    @root
        
  end
    
  def build_tree(ary = @ary, start_index = 0, end_index = ary.length - 1)
    
      # build the binary search tree
      return nil if start_index > end_index
        
      middle_index = (start_index + end_index) / 2
      self.root = Node.new(ary[middle_index], 
                           left_children = build_tree(ary, start_index, middle_index - 1),
                           right_children = build_tree(ary, middle_index + 1, end_index) 
                          )
    
  end
    
  def insert(value, current_node = self.root)
        
    if value < current_node.data && current_node.left_children == nil 
      current_node.left_children = Node.new(value, nil, nil)
      return
            
    elsif value > current_node.data && current_node.right_children == nil
      current_node.right_children = Node.new(value, nil, nil)
      return
            
    elsif value < current_node.data
      current_node = current_node.left_children
            
    else 
      current_node = current_node.right_children
            
    end
        
      insert(value, current_node)
  end
    
  def delete(value, current_node = self.root, parent_node = Node.new, node_to_replace = 0)
        
    if ( (value == current_node.left_children || value == current_node.right_children) && 
         ( (current_node.left_children.left_children == nil && current_node.left_children.right_children == nil) || 
         (current_node.right_children.left_children == nil && current_node.right_children.right_children == nil) ) )
            
      return current_node = nil
        
    elsif ( (value == current_node.data) && (current_node.left_children != nil) && (current_node.right_children != nil) ) 
            
      node_to_replace = current_node
           
      current_node = current_node.right_children 
            
      if current_node.left_children != nil 

        until current_node.left_children == nil do 
          parent_node = current_node
          current_node = current_node.left_children
        end
    
        parent_node.left_children = current_node.right_children
        node_to_replace.data = current_node.data
        return
            
      else
        node_to_replace.data = current_node.data
        node_to_replace.right_children = nil
                
        return
      end
        
      elsif value == current_node.data && current_node.left_children == nil
            
        parent_node.left_children = current_node.right_children
        return
        
      elsif value == current_node.data && current_node.right_children == nil
            
        parent_node.right_children = current_node.left_children
        return
            
      elsif value < current_node.data
        parent_node = current_node
        current_node = current_node.left_children
           
      else 
        parent_node = current_node
        current_node = current_node.right_children
            
      end
        
        delete(value, current_node, parent_node, node_to_replace)
    end

  def find(value, current_node = self.root)
      
    return current_node if value == current_node.data
     
    if value < current_node.data
      current_node = current_node.left_children
        
    else 
      current_node = current_node.right_children
          
    end
      
    find(value, current_node)
  end
 def level_order(queue = Array.new, list = Array.new, current_node = self.root)
      
    list << current_node.data
    
    queue << current_node.left_children unless current_node.left_children == nil
    queue << current_node.right_children unless current_node.right_children == nil
    
    return list if queue.empty?
    
    level_order(queue, list, queue.shift)
  end
      
  def preorder(node = self.root, list = Array.new)
      
    return list if node == nil
    
    list << node.data
    preorder(node.left_children, list)
    preorder(node.right_children, list)
  
  end

  def inorder(node = self.root, list = Array.new)
      
    return list if node == nil
    
    inorder(node.left_children, list)
    list << node.data
    inorder(node.right_children, list)
  
  end

  def postorder(node = self.root, list = Array.new)
      
    return list if node == nil
    
    postorder(node.left_children, list)
    postorder(node.right_children, list)
    list << node.data
  
  end

  def height(value, node = self.find(value), counter = 0, record = [0])
    
    record[0] = counter if record[0] < counter

    return record[0] - 1 if node == nil 

    height(value, node.left_children, counter + 1, record)
    height(value, node.right_children, counter + 1, record)
  end

  def depth(value, current_node = self.root, counter = 0)
      
    return counter if value == current_node.data
     
    if value < current_node.data
      current_node = current_node.left_children
        
    else 
      current_node = current_node.right_children
          
    end
      
    depth(value, current_node, counter + 1)
  end

  def leafs(leaf_nodes = Array.new, node = self.root, queue = Array.new)
    
    leaf_nodes << node.data if node.left_children == nil && node.right_children == nil
    
    queue << node.left_children unless node.left_children == nil
    queue << node.right_children unless node.right_children == nil

    return leaf_nodes if queue.empty?

    leafs(leaf_nodes, queue.shift, queue)
    
  end

  def balanced?(list = self.leafs)
  
    shortest = self.depth(list[0], self.root)
    tallest = 1
    
    i = 0 
    while i < list.length do 
      list[i]
      height = self.depth(list[i], self.root)
      
      if shortest > height then
        shortest = height  
      end
      
      if tallest < height then 
        tallest = height
      end
      
      shortest
      tallest
      i += 1 
    end
    tallest
    shortest
    
    if tallest - shortest == 1 || tallest - shortest == 0
      return true
    else 
      return false
    end
    
  end
  
  def rebalance(list = self.preorder)
    
    list = list.sort
    self.build_tree(list)
     
  end
  
end

# 1. Create a binary search tree from an array of randomnumbers (`Array.new(15) { rand(1..100) }`)
a = Tree.new(Array.new(15) { rand(1..100) })
a.build_tree
# 2. Confirm that the tree is balanced by calling `#balanced?`
# a.balanced?
a.balanced?

# 3. Print out all elements in level, pre, post, and in order
a.level_order
a.preorder
a.inorder
a.postorder

# 4. try to unbalance the tree by adding several numbers > 100
a.insert(101)
a.insert(150)
a.insert(151)
a.insert(252)
a.insert(300)

# 5. Confirm that the tree is unbalanced by calling `#balanced?`
a.balanced?

# 6. Balance the tree by calling `#rebalance`
a.rebalance

# 7. Confirm that the tree is balanced by calling `#balanced?`
a.balanced?

# 8. Print out all elements in level, pre, post, and in order
a.level_order
a.preorder
a.inorder
a.postorder  




