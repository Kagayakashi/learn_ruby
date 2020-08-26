puts "Вывод месяцев с 30 днями:"

months = Hash.new
months['Январь'] = 31
months['Февраль'] = 29
months['Март'] = 31
months['Апрель'] = 30
months['Май'] = 31
months['Июнь'] = 30
months['Июль'] = 31
months['Август'] = 31
months['Сентябрь'] = 30
months['Октябрь'] = 31
months['Ноябрь'] = 30
months['Декабрь'] = 31

months.each do |month, days|
  puts "#{month} -> #{days}" if days == 30
end
