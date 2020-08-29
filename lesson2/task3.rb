puts "Массив фибаначчи до 100:"
numbers = [0, 1]

loop do
  next_number = numbers.last(2).sum
  break if next_number > 100
  numbers.push(next_number)
end

puts numbers
