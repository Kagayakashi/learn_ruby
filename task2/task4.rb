puts "Хеш латинских букв и их порядковый номер"

letters = ("A".."Z").to_a
vowels = ["A","E","I","O","U","Y"]
letter_hash = Hash.new

# Заполнить хеш буквами и порядковым номером
letters.count.times do |order|
  letter = letters[order]
  if vowels.include?(letter)
    letter_hash[letter] = order + 1
  end
end

# Вывести хеш букв
letter_hash.each do |letter, order|
  puts "#{letter} -> #{order}"
end
