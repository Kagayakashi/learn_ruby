puts "Как вас зовут?"
user_name = gets.chomp

puts "#{user_name}, какой у вас рост? Мы посчитаем для вас идеальный вес"
user_height = gets.chomp.to_i

ideal_weight = (user_height - 110) * 1.15

puts ideal_weight < 0 ? "#{user_name}, ваш вес уже оптимальный." : "#{user_name}, ваш идеальный вес #{ideal_weight.to_i}кг."