
# LINKED LIST NODE 
class LLNode
  attr_accessor :value, :right
  def initialize(val = 0, nptr = nil)
    @value = val
    @right = nptr
  end
end

# INHERITED THE LLNODE FOR VALUES AND RIGHT POINTER
class BstNode < LLNode
  attr_accessor :left
  def initialize(value = 0, left = nil, right = nil)
    @left = left
    super(value,right)
  end
end

# bst helper class conatins all bst functions
class BstFunctions
  attr_accessor :root, :n_arr
  def initialize()
    @root = nil
    @n_arr = []
  end

=begin
   insert funtion
   if root is null add root , other wise go to the desired position of insert 
   then adding element iteratively
=end
  def insert(value)
    if !@root
      @root = BstNode.new(value)
    else
      curr = @root
      prev = @root
      while curr
        prev = curr
        curr = value < curr.value ? curr.left : curr.right
      end
      if value < prev.value
        prev.left = BstNode.new(value)
      else
        prev.right = BstNode.new(value)
      end
    end
  end

  def inorder(node = @root)
    if node
      inorder(node.left)
      print node.value,"  "
      inorder(node.right)
    end
  end

  def preorder(node = @root)
    if node
      print node.value,"  "
      preorder(node.left)
      preorder(node.right)
    end
  end

  def postorder(node = @root)
    if node
      postorder(node.left)
      postorder(node.right)
      print node.value," "
    end
  end

  def max_ele(node = @root)
    node = node.right while node.right
    node
  end

  def min_ele(node = @root)
    node = node.left while node.left
    node
  end

  def find(node = self.root, value)
    if !node
      return false
    elsif  node.value == value
      return true
    elsif node.value < value
      return find(node.right, value)
    else return find(node.left, value)
    end
  end

  def remove(value, node = @root)
    if !node
      return nil
    end
    if node.value > value
      node.left = remove(value, node.left)
    elsif node.value < value
      node.right = remove(value, node.right)
    else
      if node.left and node.right
        rmin = min_ele(node.right)
        node.value = rmin.value
        node.right = remove(rmin.value, node.right)
      elsif node.left
        node = node.left
      elsif node.right
        node = node.right
      else
        node = nil
      end
    end
    node
  end

  def print_path_utils(node = @root, basepath, arr)
    if !node
      return
    end
    basepath += node.value.to_s
    if !node.left and !node.right
      puts basepath
      return 
    end
    basepath += " "
    print_path_utils(node.left, basepath,arr)
    print_path_utils(node.right, basepath,arr)
  end

  def print_all_paths()
    arr = []
    basepath = ""
    print_path_utils(@root, basepath, arr)
    for i in arr do
      puts i
    end
  end

  def generate_bst(tree)
    puts " generating bst...."
    for i in tree.n_arr do
      tree.insert(i.to_i)
    end
    puts " bst generated "
  end
end

# LINEKD LIST ALL FUNCTIONS
class LLFunctions
  attr_accessor :root, :n_arr
  def initialize(root = nil)
    @root = root
    @n_arr = []
  end
  def insert(val)
    if !@root
      @root = LLNode.new(val)
    else
      temp = @root
      temp = temp.right while temp.right
      temp.right = LLNode.new(val)
    end
  end
  def traverse(node = @root)
    temp = node
    while temp
      print temp.value," "
      temp = temp.right
    end
  end
  def generate_list(ll)
    puts " generating list...."
    for i in ll.n_arr do
      ll.insert(i.to_i)
    end
    puts "linked list generated "
  end

  def find(value)
    temp = @root
    while temp.right
      if temp.value == value
        return temp
      else 
        temp = temp.right
      end
    end
    if temp.value == value
      return temp
    end
    nil
  end
  def reverse(node = @root)
    prev = nil
    curr = node
    until !curr
      temp = curr.right
      curr.right = prev
      prev = curr
      curr = temp
    end
    return @root = prev
  end
  def delete(value)
    @n_arr.delete(value)
    node = @root
    if node.value == value
      @root = @root.right
      puts " node successfully deleted "
      return 
    end
    while node.right.value != value
      node = node.right
    end
    node.right = node.right.right
    puts " node successfully deleted "
  end
end

def bst_helper

  tree = BstFunctions.new()
  puts " type 0 to create a new bst"
  puts " type 1 to load last bst"
  b = gets.to_i
  if b == 0
    puts " Please enter the comma seprated elements to add in bst, like this ex: 1,2,3"
    s = gets.chomp
    temp_arr = s.split(",")
    tree.n_arr = temp_arr.uniq
    tree.generate_bst(tree)
  elsif b == 1
    tree.n_arr = File.read("sample_tree").split
    tree.generate_bst(tree)
  end 

  puts " type 1 for inorder travsersal of bst"
  puts " type 2 for postorder travsersal of bst"
  puts " type 3 for preorder travsersal of bst"
  puts " type 4 for max element of bst"
  puts " type 5 for min element of bst"
  puts " type 6 to check if a element is present or not"
  puts " type 7 to delete an element "
  puts " type 8 to print all paths of this bst"
  puts " type 9 to save and exit an element in bst"
  puts " type 10 to exit without save "

  while true
    a = gets.to_i
    case a  
    when 1
      puts  tree.inorder
    when 2
      puts  tree.postorder
    when 3
      puts  tree.preorder
    when 4
      puts  tree.max_ele.value
    when 5
      puts  tree.min_ele.value
    when 6
      puts " enter element to find"
      a = gets.to_i
      if tree.find(a)
        puts "true"
      else print " element not present "
      end
    when 7
      puts " enter element to delete "
      a = gets.to_i
      if tree.find(a)
        tree.remove(a)
        tree.n_arr.delete(a)
        puts " element successfully deleted "
      else puts "element not present "
      end
    when 8
      tree.print_all_paths
    when 9
      #exit and save
      File.open("sample_tree","w+") do |f|
        f.puts(tree.n_arr)
      end
      break
    when 10 
      break
    end
  end
end
def ll_helper

  ll = LLFunctions.new()
  puts " type 0 to create a linked list"
  puts " type 1 to load last linked list"
  b = gets.to_i
  if b == 0
    puts " Please enter the comma seprated elements to add in linked list, like this ex: 1,2,3"
    ll.n_arr = gets.chomp.split(",").uniq
    ll.generate_list(ll)
  elsif b == 1
    ll.n_arr = File.read("sample_linked_list").split
    ll.generate_list(ll)
  end
  puts " type 1 for print linked list "
  puts " type 2 to search an element in the linked list "
  puts " type 3 to delete an element from linked list"
  puts " type 4 to reverse the linked list"
  puts " type 5 to save and exit an element in bst"
  puts " type 6 to exit without save "

  while true
    a = gets.to_i
    case a  
    when 1
      puts  ll.traverse
    when 2
      puts " enter element to search in linked list "
      num = gets.to_i
      if ll.find(num)
        puts true
      else 
        puts false
      end
    when 3
      puts " enter element to delete in linked list " 
      num = gets.to_i
      if ll.find(num)
        puts " found #{num} in the list \n now deleting the number"
        ll.delete(num)
        ll.n_arr.delete(num)
        puts " now the array is "
        puts ll.n_arr
      end
    when 4
      puts  ll.traverse(ll.reverse)
    when 5
      File.open("sample_linked_list","w+") do |f|
      f.puts(ll.n_arr)
      end
      break
    when 6
      break
    end
  end
end


puts " choose 0 to work on bst \n choose 1 to work with linked list"
choice = gets.to_i
if choice == 0
  bst_helper
  #binary search tree    # linked list
else
  ll_helper 
end
