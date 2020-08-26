puts "Хеш латинских букв и их порядковый номер"

letters = ("A".."Z").to_a
letter_hash = Hash.new

# Заполнить хеш буквами и порядковым номером
letters.count.times do |order|
  letter_hash[letters[order]] = order + 1
end

# Вывести хеш букв
letter_hash.each do |letter, order|
  puts "#{letter} -> #{order}"
end
