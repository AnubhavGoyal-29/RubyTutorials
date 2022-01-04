puts " bst code with ruby "
=begin
class BstNode
  attr_accessor :value, :left, :right
  def initialize(value=0,left=nil,right=nil)
    @value=value
    @left=left
    @right=right
  end
end

temp_root=BstNode.new(10)
puts temp_root.value
=end

puts " Please enter the number of elements to add in bst"
n_arr=[]

while(a=gets.chomp)!='exit'
  n_arr<<a
end
i=0
loop do
  puts n_arr[i]
  i+=1
  break if i==n_arr.size
end

