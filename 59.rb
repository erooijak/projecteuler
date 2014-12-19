# Each character on a computer is assigned a unique code and the preferred standard is
# ASCII (American Standard Code for Information Interchange). For example, uppercase 
# A = 65, asterisk (*) = 42, and lowercase k = 107.

# A modern encryption method is to take a text file, convert the bytes to ASCII, then 
# XOR each byte with a given value, taken from a secret key. The advantage with the XOR 
# function is that using the same encryption key on the cipher text, restores the plain 
# text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.

# For unbreakable encryption, the key is the same length as the plain text message, and 
# the key is made up of random bytes. The user would keep the encrypted message and the 
# encryption key in different locations, and without both "halves", it is impossible to 
# decrypt the message.

# Unfortunately, this method is impractical for most users, so the modified method is to 
# use a password as a key. If the password is shorter than the message, which is likely, 
# the key is repeated cyclically throughout the message. The balance for this method is 
# using a sufficiently long password key for security, but short enough to be memorable.

# Your task has been made easy, as the encryption key consists of three lower case 
# characters. Using cipher.txt (right click and 'Save Link/Target As...'), a file 
# containing the encrypted ASCII codes, and the knowledge that the plain text must 
# contain common English words, decrypt the message and find the sum of the ASCII values 
# in the original text.

cipher_values = File.read('59_cipher.txt').split(/,/).map { |str| str.to_i}
words = File.read('59_words.txt').split(/\n/)

# Encryption keys consist of three lower case characters.
possible_keys = ("a".."z").to_a.permutation(3).map { |key_arr| key_arr.join }

# Count words in sentence
def count(sentence, word)
  sentence.downcase.scan(word).size
end

# Decrypt message with the keys and count the occurrences of the common words, the 
# maximum amount is the key we are searching for.

# Decrypting means XORing the bytes with the key, then converting to string value.
decrypted_arrays = Array.new

possible_keys.each do |key|
  
  temp_cipher_values = cipher_values.clone
  decrypted_array = Array.new
  
  # Convert key to integer array
  bytes_key = key.bytes.to_a

  # XOR integer value at index 0 to byte index 0, 1 to 1, 2 to 2, 0 to 3, ...
  until temp_cipher_values.size == 1 # 1201 values total, skip 1201 % 3 because hardness.
    decrypted_array << (temp_cipher_values.shift ^ bytes_key[0])
    decrypted_array << (temp_cipher_values.shift ^ bytes_key[1])
    decrypted_array << (temp_cipher_values.shift ^ bytes_key[2])
  end

  decrypted_arrays << decrypted_array

end

result = "This will be the result."

most_matches = 0
i = 0
decrypted_arrays.each do |decrypted_array|
  matches = 0
  decrypted_string = decrypted_array.map { |b| b.chr }.join
  words.each { |word| matches += count(decrypted_string, word) }
  
  if matches > most_matches then
    result = decrypted_string 
  end
  
  # Counting down till we have tried all keys...
  puts 26**3 - i 
  i = i + 1
end

puts result

# Count ASCII values in result (the actual answer)
puts "\n\n\n"
puts result.scan(/./).map { |str| str.ord }.reduce(:+)