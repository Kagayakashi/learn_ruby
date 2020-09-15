class Train
  attr_reader :speed, :num, :cars

  def initialize(num)
    @num = num
    @cars = []
    @speed = 0
    
    welcome
  end

  def car_list
    puts "Список вагонов для поезда #{@num}:"
    @cars.each {|car| puts car.num}
  end

  def speed_up
    if @speed == 10
      puts "Поезд движется на максимальной скорости!"
      return
    end
    
    @speed += 1
  end
  
  def speed_down
    if @speed == 0
      puts "Поезд уже остановлен!"
      return
    end
    
    @speed -= 1
  end
  
  def add_car(car)
    if cars_count == 100
      puts "Поезду запрещено использовать больше 100 вагонов!"
      return false
    elsif @speed != 0
      puts "Остановите поезд!"
      return false
    elsif @type != car.type
      puts "\nТип поезда и тип вагона должны совпадать!"
      return false
    end
    
    @cars << car
  end
  
  def del_car(car)
    if cars_count == 0
      puts "У поезда нет вагонов!"
      return
    elsif @speed != 0
      puts "Остановите поезд!"
      return
    end
    
    @cars.delete(car)
  end
  
  def route=(route)
    @route = route
    @station_number = 0
    current_station.add(self)
  end
  
  def goto_next_station
    if current_station == @route.last_station
      puts "Мы находимся на последней станции!"
      return
    elsif @speed == 0
      puts "Поезд не движется!"
      return
    end
    
    current_station.del(self)
    @station_number += 1
    current_station.add(self)
  end
  
  def goto_prev_station
    if current_station == @route.first_station
      puts "Мы находимся на первой станции!"
      return
    elsif @speed == 0
      puts "Поезд не движется!"
      return
    end
    
    current_station.del(self)
    @station_number -= 1
    current_station.add(self)
  end

  def stations
    puts "Предыдущая станция: #{prev_station.name}." if prev_station
    puts "Текущая станция: #{current_station.name}."
    puts "Следующая станция: #{next_station.name}." if next_station
  end
  
  private
  # Используется только внутри класса вызовом метода add car, del car
  def cars_count
    @cars.count
  end

  # Используется только внутри класса вызовом метода stations
  def current_station
    @route.stations[@station_number]
  end
  # Используется только внутри класса вызовом метода stations
  def next_station
    @route.stations[@station_number + 1]
  end
  # Используется только внутри класса вызовом метода stations
  def prev_station
    @route.stations[@station_number - 1] if @station_number.positive?
  end

  # Используется только внутри класса во время инициализации
  def welcome
    puts "Поезд #{@type} - #{@num} создан."
  end
end
