class Train
  attr_reader :speed, :car_amount, :num, :type, :car_amount
  attr_writer :route

  def initialize(num, type, car_amount)
    @num = num
    @type = type
    @car_amount = car_amount
    @speed = 0
    
    welcome
  end
  
  def welcome
    puts "Поезд #{@type} - #{@num} создан."
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
  
  def add_car
    if @car_amount == 100
      puts "Поезду запрещено использовать больше 100 вагонов!"
      return
    elsif @speed != 0
      puts "Остановите поезд!"
      return
    end
    
    @car_amount += 1
  end
  
  def del_car
    if @car_amount == 0
      puts "У поезда нет вагонов!"
      return
    elsif @speed != 0
      puts "Остановите поезд!"
      return
    end
    
    @car_amount -= 1
  end
  
  def route=(route)
    @route = route
    @station_number = 0
  end
  
  def goto_next_station
    if @station_number == @route.stations.length
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
    if @station_number == 0
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
  
  def current_station
    @route.stations[@station_number]
  end
  
  def next_station
    @route.stations[@station_number + 1]
  end
  
  def prev_station
    @route.stations[@station_number - 1] if @station_number.positive?
  end
  
  def stations
    puts "Предыдущая станция: #{prev_station.name}." if prev_station
    puts "Текущая станция: #{current_station.name}."
    puts "Следующая станция: #{next_station.name}." if next_station
  end
  
end
