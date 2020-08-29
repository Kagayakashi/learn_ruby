require_relative 'route'

class Train
  
  attr_reader :speed, :car_amount
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
    @station_number = 1
    
    update_station
  end
  
  def next_station
    if @station_number == @route.max_stations
      puts "Мы находимся на последней станции!"
      return
    end
    
    @station_number += 1
    update_station
  end
  
  def prev_station
    if @station_number == 1
      puts "Мы находимся на первой станции!"
      return
    end
  
    @station_number -= 1
    update_station
  end
  
  def update_station
    @current_station = @route.stations.key(@station_number)
    @next_station = @route.stations.key(@station_number + 1)
    @prev_station = @route.stations.key(@station_number - 1)
  end
  
  def stations
    puts "Предыдущая станция: #{@prev_station == nil ? "~" : @prev_station}.\nТекущая станция: #{@current_station}.\nСледующая станция: #{@next_station == nil ? "~" : @next_station}."
  end
  
end

train = Train.new("Вулкан", "Пассажирский", 8)

route = Route.new("Париж", "Берлин")

route.add("Барселона", 2)
route.add("Рига", 3)
train.route = route

puts train.speed
puts train.car_amount

train.speed_up # 1
train.speed_up # 2
train.speed_up # 3
train.speed_up # 4
train.speed_up # 5
train.speed_up # 6
train.speed_up # 7
train.speed_up # 8
train.speed_up # 9
train.speed_up # 10
train.speed_up # max
train.speed_up # max

puts train.speed

train.speed_down # 9
train.speed_down # 8

puts train.speed

train.speed_down # 7
train.speed_down # 6
train.speed_down # 5
train.speed_down # 4
train.speed_down # 3
train.speed_down # 2

train.add_car
train.del_car

train.speed_down # 1
train.speed_down # stop
train.speed_down # stop

puts train.speed

train.add_car
train.del_car

puts train.car_amount

train.stations

train.next_station
train.next_station
train.next_station

train.stations
