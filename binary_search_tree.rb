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
end

a = Tree.new([1,2,3,4,5,6,7])
a.build_tree
a
a.delete(2)
p a


