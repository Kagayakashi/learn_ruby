puts "Давайте посчитаем площать треугольника в см."
puts "Укажите основание: "
base = gets.chomp.to_i

puts "Укажите высоту:"
height = gets.chomp.to_i

area = 0.5 * base * height
puts "Площать треугольника равна #{area}"