puts "Массив от 10 до 100 с шагом 5:"

numbers = []

(10..100).step(5){ |x| numbers.push(x) }

puts numbers
