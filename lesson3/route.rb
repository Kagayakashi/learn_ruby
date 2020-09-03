class Route

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]

    welcome
  end
  
  def welcome
    puts "Маршрут от #{@stations[0].name} до #{@stations[1].name} создан!"
  end
  
  def add(station)
    @stations.insert(-2, station) # Вставить элемент перед последним
    puts "\nВ маршрут добавлена станция #{station.name}."
  end
  
  def del(station)
    @stations.delete(station)
    puts "\nИз маршрута удалена станция #{station.name}."
  end
  
  def list
    puts "\nСписок станций:\n"
    @stations.each {|station| puts station.name}
  end

end
