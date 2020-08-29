products = Hash.new

loop do
  puts "Введите название продукта, либо введите (стоп) для завершения списка:"
  product_name = gets.chomp
  
  break if product_name.include?("стоп")
  
  puts "Введите количество выбранного товара #{product_name}:"
  product_amount = gets.chomp.to_f
  
  puts "Введите цену выбранного товара #{product_name}:"
  product_price = gets.chomp.to_f
  
  product_info = {
    "amount" => product_amount, "price" => product_price
  }
  products[product_name] = product_info
  
end

puts "\nСписок ваших продуктов:"

general_sum = 0;

products.each do |product, info|
  sum = info["amount"] * info["price"] # Сумма за продукт
  general_sum += sum # Общая сумма
  puts "#{product}, #{info["amount"]} шт., #{info["price"]}$ за штуку; Сумма #{sum}"
end

puts "Общая сумма за продукты #{general_sum}$."
