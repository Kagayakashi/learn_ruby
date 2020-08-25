puts "Введите три коэффициента:"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

d = b * b - 4 * a * c
x1 = (-b + c) / (2 * a)
x2 = (-b - c) / (2 * a)

if d > 0
  x1 = (-b - Math.sqrt(d)) / (2 * a)
  x2 = (-b + Math.sqrt(d)) / (2 * a)
  puts "Дискриминант #{d}. Первый корень #{x1}, второй корень #{x2}"
elsif d < 0
  puts "Дискриминант #{d}. Корней нет."
else
  x1 = -b / (2 * a)
  puts "Дискриминант #{d}. Корень #{x1}"
end