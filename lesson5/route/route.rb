class Route
  include InstanceCounter # Модуль счётчика экземпляров класса

  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    welcome
    register_instance
    puts "Создано #{self.instances} экземпляра маршрута."
  end
  
  def welcome
    puts "#{name} создан!"
  end
  
  def name
    "Маршрут от #{@first_station.name} до #{@last_station.name}"
  end
  
  def add(station)
    @stations << station
    puts "\nВ маршрут добавлена станция #{station.name}."
  end
  
  def del(station)
    @stations.delete(station)
    puts "\nИз маршрута удалена станция #{station.name}."
  end
  
  def list
    puts "\nСписок станций:\n"
    puts @first_station.name

    @stations.each {|station| puts station.name}

    puts @last_station.name
  end

end
