class Route

  attr_reader :stations, :max_stations

  def initialize(route_start, route_end)
    @route_start = route_start
    @route_end = route_end
    
    @max_stations = 3
    
    @stations = {
      route_start => 1,
      route_end => @max_stations,
    }
    
    welcome
  end
  
  def welcome
    puts "Маршрут от #{@route_start} до #{@route_end} создан!"
  end
  
  def first_station
    @stations.keys[0]
  end
  
  def add(name, order)
    if @stations.has_key?(name)
      puts "\nНазвание станции уже занято. Станция не добавлена."
      return
    elsif @stations.has_value?(order)
      puts "\nПорядковый номер станции уже занят. Станция не добавлена."
      return
    end
    
    @stations[name] = order
    puts "\nВ маршрут добавлена станция #{name}."
  end
  
  def del(name)
    if @stations[name] == 1 || @stations[name] == @max_stations
      puts "Нельзя удалить первоначальные станции"
      return
    end
    
    @stations.delete(name)
    puts "\nИз маршрута удалена станция #{name}."
  end
  
  def list
    puts "\nСписок станций:\n"
    filter = proc {|_name, order| order}
    #@stations.sort_by {|_name, order| order}.each {|name, _order| puts name}
    @stations.sort_by(&filter).each {|name, _order| puts name}
  end

end

path = Route.new("Париж", "Берлин")

path.add("Барселона", 2)
path.add("Барселона", 2) # промежуточная станция не добавлена
path.add("Рига", 1)      # промежуточная станция не добавлена

path.add("Рига", 3)

path.list # Список всего маршрута

path.del("Барселона") # Удалить станцию

path.list
