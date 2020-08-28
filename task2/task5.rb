puts "Пожалуйста, введите дату в числовом формате."

puts "Год:"
input_year = gets.chomp.to_i

puts "Месяц:"
input_month = gets.chomp.to_i

puts "День:"
input_day = gets.chomp.to_i

# Весокосный год или нет
if input_year % 400 == 0
  extra_day = 1
elsif input_year % 100 == 0
  extra_day = 0
elsif input_year % 4 == 0
  extra_day = 1
else
  extra_day = 0
end

# Посчитать количество дней используя месяц
days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_count = 0

i = 1
while i < input_month
  days_count += days_in_months[i-1]
  i += 1
end

days_count += input_day + extra_day

puts days_count
