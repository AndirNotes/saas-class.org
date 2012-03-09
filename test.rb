
class Test
    def method_missing(method_id)
       p "Method not found '#{method_id}'!!!" 
    end     
end

t = Test.new

t.hello
