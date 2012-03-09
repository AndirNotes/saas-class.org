=begin
1. open classes, metaprogramming, duck typing
a) [ELLS ex. 3.11] Extend the currency-conversion example from lecture so that you can write
5.dollars.in(:euros)
10.euros.in(:rupees)
etc.
? You should support the currencies 'dollars', 'euros', 'rupees' , 'yen' where the
conversions are: rupees to dollars, multiply by 0.019; yen to dollars, multiply by 0.013;
euro to dollars, multiply by 1.292.
? Both the singular and plural forms of each currency should be acceptable, e.g.
1.dollar.in(:rupees) and 10.rupees.in(:euro) should work.
You can use the code shown in lecture as a starting point if you wish; it is at http://pastebin.com/agjb5qBF
=end

# metaprogramming to the rescue!

class Numeric
    @@currencies = {'dollar' => 1, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
    
    def method_missing(method_id)
        singular_currency = method_id.to_s.gsub( /s$/, '')
        if @@currencies.has_key?(singular_currency)
            self * @@currencies[singular_currency]
        else
            super
        end
    end
    
    def in(currency)
        singular_currency = currency.to_s.gsub( /s$/, '')        
        self / @@currencies[singular_currency]
    end   
    
end

puts 5.dollars.in(:euros)
puts 10.euros.in(:rupees)
puts 5.rupees.in(:yen)

=begin
b) Adapt your solution from HW 1 "palindromes" question so that instead of writing palindrome?
("foo") you can write "foo".palindrome? HINT: this should require fewer than 5 lines of code.
=end

def palindrome?(string)
    input = string.downcase().gsub(/\W/, "")    
    input == input.reverse()
end

class String
    def palindrome?
        super(self)
    end
end

puts "A man, a plan, a canal -- Panama".palindrome? # true
puts "Madam, I'm Adam!".palindrome? #true
puts "Abracadabra".palindrome? #false

=begin
c) Adapt your palindrome solution so that it works on Enumerables. That is:
[1,2,3,2,1].palindrome? # => true
(It's not necessary for the collection's elements to be palindromes themselves--only that the
top-level collection be a palindrome.) HINT: this should require fewer than 5 lines of code.
Although hashes are considered Enumerables, your solution does not need to make sense for
hashes (though it should not error).
=end

module Enumerable
    def palindrome?
        self.to_a == self.to_a.reverse
    end
end

class NumberPalindromeGenerator
    include Enumerable
    
    def initialize(r1, r2)
        a = Range.new(r1, r2, true).to_a
        
        @array = a + [r2] + a.reverse
    end
    
    def each
        @array.each { |item| yield item }
    end
end

puts [].palindrome? # true
puts [1,2,3,2,1].palindrome? # true
puts [1,2,3,4,5].palindrome? # false
puts (NumberPalindromeGenerator.new(1, 5)).palindrome? # true 
puts (NumberPalindromeGenerator.new(1, 11)).palindrome? # true 
puts (NumberPalindromeGenerator.new(11, 25)).palindrome? # true 
puts( {"hello"=>"world"}.palindrome? ) # false, no error