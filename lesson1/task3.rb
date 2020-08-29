puts "Давайте определим тип треугольника. Укажите длину трёх сторон в см. :"
first_side = gets.chomp.to_i
second_side = gets.chomp.to_i
third_side = gets.chomp.to_i

# Все стороны в массиве уникальны
side_array = [first_side, second_side, third_side].uniq

# Если осталось два элемента, то треугольник равнобедренный
# Если остался один элемент, то равносторонний
if side_array.count == 2
  puts "Треугольник равнобедренный."
  return
elsif side_array.count == 1
  puts "Треугольник равносторонний."
  return
end

# Гипотенуза
hypotenuse = side_array.max

# Сумма катетов в квадрате
side_array.delete(hypotenuse)
two_side_sqr_sum = 0
side_array.each do |side|
  two_side_sqr_sum += side * side
end

puts "Треугольник прямоугольный." if hypotenuse * hypotenuse == two_side_sqr_sum
