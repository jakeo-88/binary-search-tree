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
    @root
        
        
  end
    
  def build_tree(ary = @ary, start_index = 0, end_index = ary.length - 1)
      # sort array
      ary = ary.sort
        
      # remove duplicates         
      ary = ary.uniq
       
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
        
    if ( (value == current_node.data) && (current_node.left_children == nil) && (current_node.right_children == nil) )
            
      current_node.data = nil
      return
        
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
 def level_order(level, queue = Array.new, list = Array.new, current_node = self.root, counter = 0)
      
    return nil if level == 0
    return "Input level value higher than actual levels" if level > counter
    
    total = 0 
    i = 0 
    while i < level do 
        sum = 2 ** i
        total += sum
        i += 1
    end
    total
    
    return list if total == counter
    
    list << current_node.data
    
    queue << current_node.left_children unless current_node.left_children == nil
    queue << current_node.right_children unless current_node.right_children == nil
    
    return list if queue.empty?
    
    level_order(level, queue, list, queue.shift, counter + 1)
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

  def depth(value, current_node = self.root, counter = 0)
      
    return counter if value == current_node.data
     
    if value < current_node.data
      current_node = current_node.left_children
        
    else 
      current_node = current_node.right_children
          
    end
      
    depth(value, current_node, counter + 1)
  end

end

a = Tree.new([1,2,3,4,5,6,7])
a.build_tree
a
a.delete(2)
p a


