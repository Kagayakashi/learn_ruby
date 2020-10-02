class Train
  include TrainType
  include Author # Модуль - наименование производителя.
  # Задается при создании нового поезда
  # Выводится при выборе поезда для управления
  include InstanceCounter # Модуль счётчика экземпляров класса
  include Valid
  include TrainValidator
  
  attr_reader :speed, :num, :cars
  @@object_list_hash = {}
  
  PROC_CAR_LIST = proc {|car| puts "#{car.type} вагон #{car.num};"}
  
  def initialize(num)
    @num = num
    
    validate!
    
    @cars = []
    @speed = 0
    register_object(num)
    register_instance
    
    welcome
  end
  
  def welcome
    puts "Поезд #{type} - #{@num} создан."
  end
  
  def register_object(key)
    @@object_list_hash[key] = self
  end
  
  def self.find(num)
    @@object_list_hash[num]
  end

  def for_each_car(&block)
    @cars.each { |car| yield car }
  end

  def car_list
    @cars
  end

  def speed_up
    return if @speed == 10
    @speed += 1
  end
  
  def speed_down
    return if @speed == 0
    @speed -= 1
  end
  
  def add_car(car)
    return false if cars_count == 100
    return false if @speed != 0
    return false if type != car.type
    
    @cars << car
    true
  end
  
  def del_car(car)
    return if cars_count == 0
    return if @speed != 0
    
    @cars.delete(car)
  end
  
  def route=(route)
    @route = route
    @station_number = 0
    current_station.add(self)
  end
  
  def goto_next_station
    return if current_station == @route.last_station
    return if @speed == 0
    
    current_station.del(self)
    @station_number += 1
    current_station.add(self)
  end
  
  def goto_prev_station
    return if current_station == @route.first_station
    return if @speed == 0
    
    current_station.del(self)
    @station_number -= 1
    current_station.add(self)
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

end
