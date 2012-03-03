=begin
(a) Create a class Dessert with getters and setters for name and calories. Define
instance methods healthy?, which returns true if a dessert has less than 200
calories, and delicious?, which returns true for all desserts.
(b) Create a class JellyBean that extends Dessert, and add a getter and setter for
flavor. Modify delicious? to return false if the flavor is black licorice (but delicious?
should still return true for all other flavors and for all non-JellyBean desserts).
=end

class Dessert
    
    attr_accessor :name, :calories
    
    def initialize(name, calories)
        @name = name
        @calories = calories
    end
    def healthy?
        return @calories < 200
    end
    def delicious?
        return true
    end
end

class JellyBean < Dessert
    
    attr_accessor :flavor
    
    def initialize(name, calories, flavor)
        super(name, calories)
        @flavor = flavor
    end
    def delicious?
        if @flavor == "black licorice" then return false end
        
        return super
    end    
end

dessert = Dessert.new("My Dessert", 100)

puts dessert.name
puts dessert.healthy?
puts dessert.delicious?

jellyBean = JellyBean.new("JellyBean", 0, "test")

puts jellyBean.name
puts jellyBean.healthy?
puts jellyBean.delicious?
puts jellyBean.flavor

jellyBean.name = "JellyBean with licorice"
jellyBean.calories = 250
jellyBean.flavor = "black licorice"

puts jellyBean.healthy?
puts jellyBean.delicious?
puts jellyBean.flavor

