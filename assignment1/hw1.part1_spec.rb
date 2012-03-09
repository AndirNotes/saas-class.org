require '.\hw1.part1.rb'

describe "palindrome_tests" do
    it "must find palindromes in phrases" do
        palindrome?("A man, a plan, a canal -- Panama").should be_true
        palindrome?("Madam, I'm Adam!").should be_true        
    end 

    it "shouldn't find palindromes in phrases" do
        palindrome?("Abracadabra").should be_false
        palindrome?("Madam, I'm Adem!").should be_false        
    end 
end