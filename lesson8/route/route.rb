class Route
  include InstanceCounter # Модуль счётчика экземпляров класса

  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    
    register_instance
  end
  
  def name
    "Маршрут от #{@first_station.name} до #{@last_station.name}"
  end
  
  def add(station)
    @stations << station
  end
  
  def del(station)
    @stations.delete(station)
  end
  
  def list
    @first_station + @stations + @last_station
  end

end
