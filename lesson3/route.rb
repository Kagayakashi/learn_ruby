class Route

  def initialize(route_start, route_end)
    @route_start = route_start
    @route_end = route_end
    @stations = {}
    welcome
  end
  
  def welcome
    puts "Маршрут от #{@route_start} до #{@route_end} создан!"
  end
  
  def add(name, order)
    if @stations.has_key?(name)
      puts "\nНазвание станции уже занято. Станция не добавлена."
      return
    end
    
    if @stations.has_value?(order)
      puts "\nПорядковый номер станции уже занят. Станция не добавлена."
      return
    end
    
    @stations[name] = order
    puts "\nВ маршрут добавлена станция #{name}."
  end
  
  def del(name)
    @stations.delete(name)
    puts "\nИз маршрута удалена станция #{name}."
  end
  
  def list
    puts "\nСписок станций:\n#{@route_start}"
    filter = proc {|_name, order| order}
    #@stations.sort_by {|_name, order| order}.each {|name, _order| puts name}
    @stations.sort_by(&filter).each {|name, _order| puts name}
    puts @route_end
  end

end

path = Route.new("Париж", "Берлин")

path.add("Барселона", 1)
path.add("Барселона", 2) # промежуточная станция не добавлена
path.add("Рига", 1)      # промежуточная станция не добавлена

path.add("Рига", 2)

path.list # Список всего маршрута

path.del("Барселона") # Удалить станцию

path.list
