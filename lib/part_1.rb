def partition (array, num)
    less_than= []
    greater_than=[]
    array.map { |ele| 
        if ele < num 
            less_than << ele
        elsif 
            ele >= num 
            greater_than << ele
        end
    }
    resuly = [less_than,greater_than]
end

def merge(hash_1, hash_2)
    new_hash = {}
    hash_1.each {|k,v| new_hash[k] = v }
    hash_2.each {|k,v| new_hash[k] = v }
    new_hash
end

# Attempt 1
# def censor(sentence, swears)
#     vowels = "aeiou"
#     words = sentence.split(" ")
#     checked_words = words.map do |word|
#         if swears.any?(word)
#             word.each_char.with_index do |char,i|
#                 if vowels.include?(char)
#                     word[i] = '*'
#                 end 
#                 word
#             end
#         else
#             word
#         end
#     end 
#     checked_words.join(" ")
# end

def censor(sentence, curse_words)
    words = sentence.split(" ")

    new_words = words.map do |word|
        if curse_words.include?(word.downcase)
            star_vowels(word)
        else
            word
        end
    end

    new_words.join(" ")
end

def star_vowels(string)
    vowels = "aeiou"
    new_str = ""

    string.each_char do |char|
        if vowels.include?(char.downcase)
            new_str+= "*"
        else 
            new_str += char
        end
    end
    
    new_str
end

def power_of_two?(number)
    product  = 1
    while product < number
        product *= 2
    end
    product == number
end