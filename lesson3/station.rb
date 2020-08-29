class Station

  def initialize(name)
    @name = name
    @trains = {}
    welcome
  end

  def welcome
    puts "Добро пожаловать на стацию #{@name}!"
  end

  # По умолчанию вызвать список вагонов, либо произвольный список
  def list(trains = @trains)
    puts "\nСписок поездов на станции:"
    trains.each {|num, info| puts "Поезд #{info["type"]} - #{num}, #{info["cars_amount"]} вагонов."}
  end
  
  # Отфильтровать список вагонов по типу и вызвать метод train_list
  def list_with_type(type)
    type_filter = proc {|_num, info| type == info["type"]}
    list(@trains.select(&type_filter))
  end

  def get(num, type, cars_amount)
    if @trains.has_key?(num)
      puts "\nПоезд #{num} уже находится на станции."
      return
    end
    
    @trains[num] = {
      "type" => type,
      "cars_amount" => cars_amount,
    }
  end

  def send(num)
    @trains.delete(num)
    puts "\nПоезд - #{num} отправлен."
  end

end

new_station = Station.new("Рига")

new_station.get("Вулкан", "Пассажирский", 8)
new_station.get("Вулкан", "Пассажирский", 8) # Попытка проникнуть на станцию
new_station.get("Вулкан2", "Пассажирский", 12)
new_station.get("Вулкан3", "Грузовой", 64)

new_station.list #Список всех вагонов

new_station.list_with_type("Грузовой") #Список вагонов по типу

new_station.list

new_station.send("Вулкан2") # Отправить второй пассажирский вагон

new_station.list
