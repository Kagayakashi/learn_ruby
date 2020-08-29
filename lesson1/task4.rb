puts "Введите три коэффициента:"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

d = b * b - 4 * a * c

a2 = 2 * a

if d > 0
  d_sqrt = Math.sqrt(d)
  x1 = (-b - d_sqrt) / a2
  x2 = (-b + d_sqrt) / a2
  puts "Дискриминант #{d}. Первый корень #{x1}, второй корень #{x2}"
elsif d < 0
  puts "Дискриминант #{d}. Корней нет."
else
  x1 = -b / a2
  puts "Дискриминант #{d}. Корень #{x1}"
end
