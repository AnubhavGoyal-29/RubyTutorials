# bst node class
class BstNode
  attr_accessor :value, :left, :right
  def initialize(value = 0, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

# bst helper class conatins all bst functions
class BstFunctions
  attr_accessor :root, :n_arr
  def initialize()
    @root = nil
    @n_arr = []
  end

  # insert funtion
  # if root is null add root , other wise go to the desired position of insert 
  # then adding element iteratively
  def insert(value)
    if @root == nil
      @root = BstNode.new(value)
    else
      curr = @root
      prev = @root
      while curr != nil
        prev = curr
        if value < curr.value
          curr = curr.left
        else 
          curr = curr.right
        end
      end

      if value < prev.value
        prev.left = BstNode.new(value)
      else
        prev.right = BstNode.new(value)
      end
    end
  end


  def inorder(node = @root)
    if node != nil
      inorder(node.left)
      print node.value,"  "
      inorder(node.right)
    end
  end

  def preorder(node = @root)
    if node != nil
      print node.value,"  "
      preorder(node.left)
      preorder(node.right)
    end
  end

  def postorder(node = @root)
    if node != nil
      postorder(node.left)
      postorder(node.right)
      print node.value," "
    end
  end

  def max_ele(node = @root)
    node = @root
    while node.right != nil
      node = node.right
    end
    return node
  end

  def min_ele(node = @root)
    while node.left != nil
      node = node.left
    end
    return node
  end

  def find(node = self.root, value)
    if node == nil
      return false
    elsif  node.value == value
      return true
    elsif node.value < value
      return find(node.right, value)
    else return find(node.left, value)
    end
  end

  # remove function fixed
  def remove(value, node=@root)
    if node == nil
      return nil
    end
    if node.value > value
      node.left = remove(value, node.left)
    elsif node.value < value
      node.right = remove(value, node.right)
    else
      if node.left != nil && node.right != nil
        rmin = min_ele(node.right)
        node.value = rmin.value
        node.right = remove(rmin.value, node.right)
      elsif node.left != nil
        node = node.left
      elsif node.right != nil
        node = node.right
      else
        node = nil
      end
    end
    return node
  end
  def printpathutils(node = @root, basepath, arr)
    if node.nil?
      return
    end
    basepath += node.value.to_s
    if node.left.nil? and node.right.nil?
      puts basepath
      return 
    end
    basepath += " "
    printpathutils(node.left, basepath, arr)
    printpathutils(node.right, basepath, arr)
  end
  def printallpaths()
    arr = []
    basepath = ""
    printpathutils(@root, basepath, arr)
    for i in arr do
      puts i
    end
  end
  def generatebst(tree)
    puts " generating bst...."
    for i in tree.n_arr do
      tree.insert(i.to_i)
    end
    puts " bst generated "
  end
end

tree=BstFunctions.new()
puts " type 0 to create a new bst"
puts " type 1 to load last bst"
b = gets.to_i
if b == 0
  puts " Please enter the comma seprated elements to add in bst, like this ex: 1,2,3"
  n_arr = []
  s = gets.chomp
  temp_arr = s.split(",")
  tree.n_arr = temp_arr.uniq
  puts n_arr.size
  tree.generatebst(tree)
elsif b == 1
  tree.n_arr = File.read("sample_tree").split
  tree.generatebst(tree)
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
    tree.printallpaths()
  when 9
    #exit and save
    File.open("sample_tree","w+") do |f|
      f.puts(n_arr)
    end
    break
  when 10 
    break
  end
end
