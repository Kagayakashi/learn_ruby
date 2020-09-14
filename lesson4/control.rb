require_relative 'Station/station'

require_relative 'Route/route'

require_relative 'Car/train_car'
require_relative 'Car/passenger_car'
require_relative 'Car/cargo_car'

require_relative 'Train/train'
require_relative 'Train/passenger_train'
require_relative 'Train/cargo_train'

STATE_MENU = 10
STATE_CREATE_STATION = 20
STATE_CREATE_PASSENGER_TRAIN = 30
STATE_CREATE_CARGO_TRAIN = 40
STATE_CREATE_PASSENGER_CAR = 50
STATE_CREATE_CARGO_CAR = 60
STATE_CREATE_ROUTE = 70
STATE_ADD_STATION_TO_ROUTE = 80
STATE_DEL_STATION_FROM_ROUTE = 90
STATE_TRAIN_CONTROL = 100
STATE_TRAIN_MENU = 110
STATE_TRAIN_ADD_STATION = 120
STATE_TRAIN_SPEED_UP = 130
STATE_TRAIN_SPEED_DOWN = 140
STATE_TRAIN_GOTO_NEXT_STATION = 150
STATE_TRAIN_GOTO_PREV_STATION = 160
STATE_TRAIN_STATION_LIST = 170
STATE_TRAIN_ADD_CAR = 180
STATE_TRAIN_DEL_CAR = 190

class Controller

  def initialize
    @stations = []
    @trains = []
    @cars = []
    @routes = []
    @choosen_route
    @choosen_train
    @state = STATE_MENU

    @name_with_index = Proc.new {|s, i| puts "#{i} - #{s.name}"}
    @num_with_index = Proc.new {|s, i| puts "#{i} - #{s.num}(#{s.type})"}

    run
  end
  
  # Все функции вызываются внутри класса
  private

  def run
    loop do
      render
    end
  end

  def get_input
    @input = gets.chomp
  end
  
  def render
    case @state
    when STATE_MENU then render_menu
    when STATE_CREATE_STATION then render_create_station
    when STATE_CREATE_PASSENGER_TRAIN then render_create_passenger_train
    when STATE_CREATE_CARGO_TRAIN then render_create_cargo_train
    when STATE_CREATE_PASSENGER_CAR then render_create_passenger_car
    when STATE_CREATE_CARGO_CAR then render_create_cargo_car
    when STATE_CREATE_ROUTE then render_create_route
    when STATE_ADD_STATION_TO_ROUTE then render_add_station_to_route
    when STATE_DEL_STATION_FROM_ROUTE then render_del_station_from_route
    when STATE_TRAIN_CONTROL then render_train_control
    when STATE_TRAIN_MENU then render_train_menu
    when STATE_TRAIN_ADD_STATION then render_train_add_station
    when STATE_TRAIN_SPEED_UP then render_train_speed_up
    when STATE_TRAIN_SPEED_DOWN then render_train_speed_down
    when STATE_TRAIN_GOTO_NEXT_STATION then render_train_goto_next_station
    when STATE_TRAIN_GOTO_PREV_STATION then render_train_goto_prev_station
    when STATE_TRAIN_STATION_LIST then render_train_station_list
    when STATE_TRAIN_ADD_CAR then render_train_add_car
    when STATE_TRAIN_DEL_CAR then render_train_del_car
    when STATE_TRAIN_CAR_LIST then render_train_car_list
    end
  end
  
  def render_menu
    puts "\nГлавное меню:"
    puts "1.Создать новую станцию"
    puts "2.Создать пассажирский поезд"
    puts "3.Создать грузовой поезд"
    puts "4.Создать пассажирский вагон"
    puts "5.Создать грузовой вагон"
    puts "6.Создать маршрут"
    puts "7.Добавить станцию в выбранный маршрут"
    puts "8.Удалить станцию из выбранного маршрута"
    puts "9.Управление поездом"

    get_input

    case @input.to_i
    when 1 then @state = STATE_CREATE_STATION
    when 2 then @state = STATE_CREATE_PASSENGER_TRAIN
    when 3 then @state = STATE_CREATE_CARGO_TRAIN
    when 4 then @state = STATE_CREATE_PASSENGER_CAR
    when 5 then @state = STATE_CREATE_CARGO_CAR
    when 6 then @state = STATE_CREATE_ROUTE
    when 7 then @state = STATE_ADD_STATION_TO_ROUTE
    when 8 then @state = STATE_DEL_STATION_FROM_ROUTE
    when 9 then @state = STATE_TRAIN_CONTROL
    end
  end
  
  def render_create_station
    puts "Введите наименование для новой станции:"

    get_input
    
    station = Station.new(@input)
    
    @stations << station
    
    @state = STATE_MENU
  end

  def render_create_passenger_train
    puts "Введите номер для нового пассажирского поезда:"
    
    get_input
    
    passenger_train = PassengerTrain.new(@input)
    
    @trains << passenger_train
    
    @state = STATE_MENU
  end

  def render_create_cargo_train
    puts "Введите номер для нового грузового поезда:"
    
    get_input
    
    cargo_train = CargoTrain.new(@input)
    
    @trains << cargo_train
    
    @state = STATE_MENU
  end

  def render_create_passenger_car
    puts "Введите номер для нового пассажирского вагона:"
    
    get_input
    
    passenger_car = PassengerCar.new(@input)
    
    @cars << passenger_car
    
    @state = STATE_MENU
  end

  def render_create_cargo_car
    puts "Введите номер для нового грузового вагона:"
    
    get_input
    
    cargo_car = CargoCar.new(@input)
    
    @cars << cargo_car
    
    @state = STATE_MENU
  end

  def render_create_route
    if @stations.count < 2
      puts "\nНе достаточно станций для создания маршрута!"
      @state = STATE_MENU
      return
    end
    
    puts "Выберите начальную станцию"
    @stations.each.with_index(&@name_with_index)
    
    get_input
    station_start = @stations[@input.to_i]
    @stations.delete(station_start)
    
    puts "Выберите конечную станцию"
    @stations.each.with_index(&@name_with_index)
    
    get_input
    station_end = @stations[@input.to_i]
    @stations.delete(station_end)
    
    route = Route.new(station_start, station_end)
    @routes << route
    
    @state = STATE_MENU
  end

  def choose_route
    puts "\nВыберите маршрут:"
    @routes.each.with_index(&@name_with_index)
    
    get_input
    @choosen_route = @routes[@input.to_i]
  end

  def render_add_station_to_route
    if @stations.count == 0
      puts "\nНет станций для добавления в маршрут!"
      @state = STATE_MENU
      return
    end
    
    choose_route
    
    puts "Выберите станцию, чтобы добавить её в маршрут:"
    @stations.each.with_index(&@name_with_index)
    
    get_input
    station = @stations[@input.to_i]
    @choosen_route.add(station)
    @stations.delete(station)

    @choosen_route.list

    @state = STATE_MENU
  end

  def render_del_station_from_route
    choose_route
    
    if @choosen_route.stations.count == 0
      puts "\nНет станций для удаления из маршрута!"
      @state = STATE_MENU
      return
    end
    
    puts "Выберите станцию, чтобы удалить её из маршрута:"
    @choosen_route.stations.each.with_index(&@name_with_index)
    
    get_input
    station = @choosen_route.stations[@input.to_i]
    @choosen_route.del(station)
    @stations << station
    
    @choosen_route.list
    
    @state = STATE_MENU
  end
  
  def render_train_control
    if @trains.count == 0
      puts "\nНет поездов для выбора!"
      @state = STATE_MENU
      return
    end
    
    puts "Выберите поезд для управления:"
    @trains.each.with_index(&@num_with_index)
    get_input
    train = @trains[@input.to_i]
    @choosen_train = train
    
    @state = STATE_TRAIN_MENU
  end
  
  def render_train_menu
    puts "\nМеню поезда #{@choosen_train.num}(#{@choosen_train.type}):"
    puts "1.Выбрать маршрут"
    puts "2.Начать движение/Повысить скорость"
    puts "3.Остановить движение/Понизить скорость"
    puts "4.Ехать на следующую станцию"
    puts "5.Ехать на предыдущую станцию"
    puts "6.Список ближайших станций"
    puts "7.Прицепить вагон"
    puts "8.Отцепить вагон"

    puts "0.Назад"

    get_input

    case @input.to_i
    when 1 then @state = STATE_TRAIN_ADD_ROUTE
    when 2 then @state = STATE_TRAIN_SPEED_UP
    when 3 then @state = STATE_TRAIN_SPEED_DOWN
    when 4 then @state = STATE_TRAIN_GOTO_NEXT_STATION
    when 5 then @state = STATE_TRAIN_GOTO_PREV_STATION
    when 6 then @state = STATE_TRAIN_STATION_LIST
    when 7 then @state = STATE_TRAIN_ADD_CAR
    when 8 then @state = STATE_TRAIN_DEL_CAR
    when 9 then @state = STATE_TRAIN_CAR_LIST
    when 0 then @state = STATE_MAIN_MENU
    end
  end
  
  def render_train_add_route
    choose_route
    @choosen_train.route = @choosen_route
    
    @state = STATE_TRAIN_MENU
  end
  
  def current_speed
    puts "Текущая скорость #{@choosen_train.speed}."
  end
  
  def render_train_speed_up
    @choosen_train.speed_up
    current_speed
    
    @state = STATE_TRAIN_MENU
  end
  
  def render_train_speed_down
    @choosen_train.speed_down
    current_speed
    
    @state = STATE_TRAIN_MENU
  end
  
  def render_train_goto_next_station
    @choosen_train.goto_next_station
    
    @state = STATE_TRAIN_MENU
  end
  
  def render_train_goto_prev_station
    @choosen_train.goto_prev_station
  
    @state = STATE_TRAIN_MENU
  end
  
  def render_train_station_list
    @choosen_train.stations
    
    @state = STATE_TRAIN_MENU
  end
  
  def render_train_add_car
    @state = STATE_TRAIN_MENU
    
    if @cars.count == 0
      puts "\nНет вагонов для выбора!"
      return
    end
    
    puts "Выберите вагон:"
    @cars.each.with_index(&@num_with_index)
    get_input
    car = @cars[@input.to_i]
    
    if @choosen_train.type != car.type
      puts "\nТип поезда и тип вагона должны совпадать!"
      return
    end
    
    @choosen_train.add_car(car)
    @cars.delete(car)
  end
  
  def render_train_del_car
    @state = STATE_TRAIN_MENU
    
    if @choosen_train.cars.count == 0
      puts "\nНет вагонов для выбора!"
      return
    end
    
    puts "Выберите вагон:"
    @choosen_train.cars.each.with_index(&@num_with_index)
    get_input
    car = @choosen_train.cars[@input.to_i]
    
    if @choosen_train.type != car.type
      puts "\nТип поезда и тип вагона должны совпадать!"
      return
    end
    
    @choosen_train.del_car(car)
    @cars << car
  end
  
  def render_train_car_list
    @choosen_train.car_list
  end
  
end

app = Controller.new