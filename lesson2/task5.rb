puts "Пожалуйста, введите дату в числовом формате."

puts "Год:"
input_year = gets.chomp.to_i

puts "Месяц:"
input_month = gets.chomp.to_i

puts "День:"
input_day = gets.chomp.to_i

# Весокосный год или нет
leap_year = input_year % 400 == 0 || input_year % 4 == 0 ? true : false

# Посчитать количество дней используя месяц
days_in_months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_count = input_day

i = 1
while i < input_month
  days_count += days_in_months[i-1]
  i += 1
end

days_count -= 1 if !leap_year

puts days_count
