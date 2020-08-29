puts "Пожалуйста, введите дату в числовом формате."

puts "Год:"
input_year = gets.chomp.to_i

puts "Месяц:"
input_month = gets.chomp.to_i

puts "День:"
input_day = gets.chomp.to_i

# Весокосный год или нет
leap_year = input_year % 4 == 0 && input_year % 100 != 0 || input_year % 400 == 0

# Посчитать количество дней используя месяц
days_in_months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

days_count = input_day + days_in_months.take(input_month - 1).sum
days_count -= 1 if !leap_year

puts days_count
