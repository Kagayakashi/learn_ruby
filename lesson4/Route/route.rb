class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
    welcome
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
