puts "Пожалуйста, введите дату в числовом формате."

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Год:"
year = gets.chomp.to_i

puts "Месяц:"
month = gets.chomp.to_i

puts "День:"
day = gets.chomp.to_i

# Весокосный год или нет
# Изменить количество дней в феврале
days_in_months[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0

# Посчитать количество дней
days_count = day + days_in_months.take(month - 1).sum

puts days_count
