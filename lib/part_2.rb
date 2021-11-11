def palindrome?(string)
    string.each_char.with_index do |char, i|
        if string [i] != string[-i - 1]
            return false
        end
   end
 true
end

def substrings(string)
    match_array = []
    (0...string.length).each do |start_idx|
        (start_idx...string.length).each do |end_idx|
            match_array << string[start_idx..end_idx]
        end
    end
    match_array
end

def palindrome_substrings(string)
    substrings(string).select{ |substr| palindrome?(substr) && substr.length > 1 }
end