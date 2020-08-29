puts "Хеш латинских букв и их порядковый номер"

letters = ("A".."Z").to_a
vowels = ["A","E","I","O","U","Y"]
letter_hash = {}

# Заполнить хеш буквами и порядковым номером
letters.each.with_index(1) do |letter, order|
  letter_hash[letter] = order if vowels.include?(letter)
end

# Вывести хеш букв
letter_hash.each do |letter, order|
  puts "#{letter} -> #{order}"
end
