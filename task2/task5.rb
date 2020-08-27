puts "Пожалуйста, введите дату в числовом формате."

puts "Год:"
input_year = gets.chomp.to_i

puts "Месяц:"
input_month = gets.chomp.to_i

puts "День:"
input_day = gets.chomp.to_i

# Посчитать количество дней используя месяц
days_in_months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
result = 0

i = 0
while i < input_month
  result += days_in_months[i]
end

puts result