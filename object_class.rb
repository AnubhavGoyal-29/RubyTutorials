class Vehicle
  def initialize()
    @model_id=0
    @name="name"
    @price=0
  end
  def initialize(model_id=0,name="",price=0)
    @model_id=model_id
    @name=name
    @price=price
  end
  def print
    puts "this model with id #{@model_id}, first class #{@name} has a least price of rupees #{@price}"
  end
end

object=Vehicle.new(12,"blogvault",25000)
object.print
