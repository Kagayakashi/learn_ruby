# frozen_string_literal: true

# Подключение модулей
require_relative 'module/types/train'
require_relative 'module/author'
require_relative 'module/instance_counter'

# Модули валидации
#require_relative 'module/validate/is_valid'
#require_relative 'module/validate/station'
#require_relative 'module/validate/train'
#require_relative 'module/validate/car'
require_relative 'module/validate/validate'


# Подключение классов
require_relative 'station/station'

require_relative 'route/route'

require_relative 'car/train_car'
require_relative 'car/passenger_car'
require_relative 'car/cargo_car'

require_relative 'train/train'
require_relative 'train/passenger_train'
require_relative 'train/cargo_train'

STATE_MENU = 10
STATE_CREATE_STATION = 20
STATE_STATION_TRAINS = 21
STATE_CREATE_PASSENGER_TRAIN = 30
STATE_CREATE_CARGO_TRAIN = 40
STATE_CREATE_PASSENGER_CAR = 50
STATE_CREATE_CARGO_CAR = 60
STATE_CREATE_ROUTE = 70
STATE_ADD_STATION_TO_ROUTE = 80
STATE_DEL_STATION_FROM_ROUTE = 90
STATE_TRAIN_CONTROL = 100
STATE_TRAIN_MENU = 110
STATE_TRAIN_ADD_ROUTE = 120
STATE_TRAIN_SPEED_UP = 130
STATE_TRAIN_SPEED_DOWN = 140
STATE_TRAIN_GOTO_NEXT_STATION = 150
STATE_TRAIN_GOTO_PREV_STATION = 160
STATE_TRAIN_STATION_LIST = 170
STATE_TRAIN_ADD_CAR = 180
STATE_TRAIN_DEL_CAR = 190
STATE_TRAIN_CAR_LIST = 200
STATE_TRAIN_CAR_PARAM_ADD = 210
STATE_TRAIN_CAR_PARAM_DEL = 220

STATES_MAIN_MENU = {
  1 => STATE_CREATE_STATION,
  2 => STATE_STATION_TRAINS,
  3 => STATE_CREATE_PASSENGER_TRAIN,
  4 => STATE_CREATE_CARGO_TRAIN,
  5 => STATE_CREATE_PASSENGER_CAR,
  6 => STATE_CREATE_CARGO_CAR,
  7 => STATE_CREATE_ROUTE,
  8 => STATE_ADD_STATION_TO_ROUTE,
  9 => STATE_DEL_STATION_FROM_ROUTE,
  10 => STATE_TRAIN_CONTROL
}.freeze

RENDER_STATES = {
  STATE_MENU => method(:render_menu),
  STATE_CREATE_STATION => method(:render_create_station),
  STATE_STATION_TRAINS => method(:render_station_train_list),
  STATE_CREATE_PASSENGER_TRAIN => method(:render_create_passenger_train),
  STATE_CREATE_CARGO_TRAIN => method(:render_create_cargo_train),
  STATE_CREATE_PASSENGER_CAR => method(:render_create_passenger_car),
  STATE_CREATE_CARGO_CAR => method(:render_create_cargo_car),
  STATE_CREATE_ROUTE => method(:render_create_route),
  STATE_ADD_STATION_TO_ROUTE => method(:render_add_station_to_route),
  STATE_DEL_STATION_FROM_ROUTE => method(:render_del_station_from_route),
  STATE_TRAIN_CONTROL => method(:render_train_control),
  STATE_TRAIN_MENU => method(:render_train_menu),
  STATE_TRAIN_ADD_ROUTE => method(:render_train_add_route),
  STATE_TRAIN_SPEED_UP => method(:render_train_speed_up),
  STATE_TRAIN_SPEED_DOWN => method(:render_train_speed_down),
  STATE_TRAIN_GOTO_NEXT_STATION => method(:render_train_goto_next_station),
  STATE_TRAIN_GOTO_PREV_STATION => method(:render_train_goto_prev_station),
  STATE_TRAIN_STATION_LIST => method(:render_train_station_list),
  STATE_TRAIN_ADD_CAR => method(:render_train_add_car),
  STATE_TRAIN_DEL_CAR => method(:render_train_del_car),
  STATE_TRAIN_CAR_LIST => method(:render_train_car_list),
  STATE_TRAIN_CAR_PARAM_ADD => method(:render_train_car_param_add),
  STATE_TRAIN_CAR_PARAM_DEL => method(:render_train_car_param_del)
}.freeze

class Controller
  def initialize
    @stations = []
    @stations_all = []
    @trains = []
    @cars = []
    @routes = []
    @state = STATE_MENU

    @name_with_index = proc { |s, i| puts "#{i} - #{s.name}" }
    @num_with_index = proc { |s, i| puts "#{i} - #{s.num}(#{s.type}). Производитель #{s.author}" }

    run
  end

  # Все функции вызываются внутри класса
  private

  def run
    loop do
      render
    end
  end

  # Получения ввода от пользователя.
  # Проверка из определенного модуля и обработка ошибки с повторным вводом.
  def user_input
    @input = gets.chomp
  end

  def render
    RENDER_STATES[@state].call
  end

  def render_menu
    render_system_info

    puts "\nГлавное меню:"

    puts '1.Создать новую станцию'
    puts '2.Список поездов на станции'
    puts '3.Создать пассажирский поезд'
    puts '4.Создать грузовой поезд'
    puts '5.Создать пассажирский вагон'
    puts '6.Создать грузовой вагон'
    puts '7.Создать маршрут'
    puts '8.Добавить промежуточную станцию в маршрут'
    puts '9.Удалить промежуточную станцию из маршрута'
    puts '10.Управление поездом'

    user_input

    @state = STATES_MAIN_MENU[@input.to_i]
  end

  def render_create_station
    puts 'Введите наименование для новой станции:'
    user_input

    station = Station.new(@input)

    @stations << station
    @stations_all << station

    # Вывод всех инстансов класса станции
    puts 'Список созданных станций. Метод класса all:'
    Station.all.each(&@name_with_index)

    @state = STATE_MENU
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def render_station_train_list
    @state = STATE_MENU

    if @stations_all.count.zero?
      puts "\nНет станций для выбора!"
      return
    end

    puts 'Выберите станцию:'
    @stations_all.each.with_index(&@name_with_index)
    user_input
    station = @stations_all[@input.to_i]

    station.list
  end

  def render_create_passenger_train
    puts 'Введите номер для нового пассажирского поезда:'
    user_input

    passenger_train = PassengerTrain.new(@input)

    puts 'Введите наименовани компании-производителя:'
    user_input

    passenger_train.set_author(@input)

    @trains << passenger_train

    @state = STATE_MENU
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def render_create_cargo_train
    puts 'Введите номер для нового грузового поезда:'
    user_input

    cargo_train = CargoTrain.new(@input)

    puts 'Введите наименовани компании-производителя:'
    user_input

    cargo_train.set_author(@input)

    @trains << cargo_train

    @state = STATE_MENU
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def render_create_passenger_car
    puts 'Введите номер для нового пассажирского вагона:'
    user_input

    car_num = @input

    puts 'Введите количество мест в вагоне:'
    user_input

    car_seats = @input.to_i

    passenger_car = PassengerCar.new(car_num, car_seats)

    puts 'Введите наименовани компании-производителя:'
    user_input

    passenger_car.set_author(@input)

    @cars << passenger_car

    @state = STATE_MENU
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def render_create_cargo_car
    puts 'Введите номер для нового грузового вагона:'
    user_input

    car_num = @input

    puts 'Введите объем грузового вагона:'
    user_input

    car_volume = @input

    cargo_car = CargoCar.new(car_num, car_volume)

    puts 'Введите наименовани компании-производителя:'
    user_input

    cargo_car.set_author(@input)

    @cars << cargo_car

    @state = STATE_MENU
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def render_create_route
    @state = STATE_MENU

    if @stations.count < 2
      puts "\nНе достаточно станций для создания маршрута!"
      return
    end

    puts 'Выберите начальную станцию'
    @stations.each.with_index(&@name_with_index)

    user_input
    station_start = @stations[@input.to_i]
    @stations.delete(station_start)

    puts 'Выберите конечную станцию'
    @stations.each.with_index(&@name_with_index)

    user_input
    station_end = @stations[@input.to_i]
    @stations.delete(station_end)

    route = Route.new(station_start, station_end)
    @routes << route
  end

  def choose_route
    puts "\nВыберите маршрут:"
    @routes.each.with_index(&@name_with_index)

    user_input
    @choosen_route = @routes[@input.to_i]
  end

  def render_add_station_to_route
    if @stations.count.zero?
      puts "\nНет станций для добавления в маршрут!"
      @state = STATE_MENU
      return
    end

    choose_route

    puts 'Выберите станцию, чтобы добавить её в маршрут:'
    @stations.each.with_index(&@name_with_index)

    user_input
    station = @stations[@input.to_i]
    @choosen_route.add(station)
    @stations.delete(station)

    @choosen_route.list

    @state = STATE_MENU
  end

  def render_del_station_from_route
    choose_route

    if @choosen_route.stations.count.zero?
      puts "\nНет станций для удаления из маршрута!"
      @state = STATE_MENU
      return
    end

    puts 'Выберите станцию, чтобы удалить её из маршрута:'
    @choosen_route.stations.each.with_index(&@name_with_index)

    user_input
    station = @choosen_route.stations[@input.to_i]
    @choosen_route.del(station)
    @stations << station

    @choosen_route.list

    @state = STATE_MENU
  end

  def render_train_control
    if @trains.count.zero?
      puts "\nНет поездов для выбора!"
      @state = STATE_MENU
      return
    end

    puts 'Выберите поезд для управления:'
    @trains.each.with_index(&@num_with_index)
    user_input
    train = @trains[@input.to_i]
    @choosen_train = train

    @state = STATE_TRAIN_MENU
  end

  def render_train_menu
    current_train = @choosen_train.class.find(@choosen_train.num).num
    puts "Количество вагонов у поезда: #{@choosen_train.cars.count}"
    puts "\nМеню поезда #{current_train}(#{@choosen_train.type}):"
    puts '1.Выбрать маршрут'
    puts '2.Начать движение/Повысить скорость'
    puts '3.Остановить движение/Понизить скорость'
    puts '4.Ехать на следующую станцию'
    puts '5.Ехать на предыдущую станцию'
    puts '6.Список ближайших станций'
    puts '7.Прицепить вагон'
    puts '8.Отцепить вагон'
    puts '9.Список вагонов'

    if @choosen_train.passenger?
      puts '10.Занять место в вагоне'
      puts '11.Освободить место в вагоне'
    elsif @choosen_train.cargo?
      puts '10.Занять объем в вагоне'
      puts '11.Освободить объем в вагоне'
    end

    puts '0.Назад'

    user_input

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
    when 10 then @state = STATE_TRAIN_CAR_PARAM_ADD
    when 11 then @state = STATE_TRAIN_CAR_PARAM_DEL
    when 0 then @state = STATE_MENU
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

  def render_choose_train_car
    puts 'Выберите вагон:'
    @choosen_train.cars.each.with_index(&@num_with_index)
    user_input
    @choosen_train.cars[@input.to_i]
  end

  def render_choose_car
    puts 'Выберите вагон:'
    @cars.each.with_index(&@num_with_index)
    user_input
    @cars[@input.to_i]
  end

  def render_train_add_car
    @state = STATE_TRAIN_MENU

    if @cars.count.zero?
      puts "\nНет вагонов для выбора!"
      return
    end

    car = render_choose_car

    return if @choosen_train.add_car(car) == false

    @cars.delete(car)
  end

  def render_train_del_car
    @state = STATE_TRAIN_MENU

    if @choosen_train.cars.count.zero?
      puts "\nНет вагонов для выбора!"
      return
    end

    car = render_choose_train_car

    @choosen_train.del_car(car)
    @cars << car
  end

  def render_train_car_list
    @choosen_train.car_list
  end

  # Метод вывода puts всех данных поездов, станций и вагонов.
  def render_system_info
    return if @stations_all.count.zero?

    puts 'Информация системы:'

    @stations_all.each do |station|
      puts "Станция - #{station.name}"

      station.for_each_train do |train|
        puts "\t#{train.type} поезд - #{train.num} (Вагонов: #{train.car_list.count}):"

        train.for_each_car do |car|
          car_param = car.passenger? ? passenger_car_info(car) : cargo_car_info(car)
          puts "\t\t#{car.type} вагон - #{car.num} (#{car_param});"
        end
      end
    end
  end

  def passenger_car_info(car)
    "Свободных мест: #{car.free_seats.count}"
  end

  def cargo_car_info(car)
    "Свободный объем: #{car.free_space}"
  end

  def render_train_car_param_add
    car = render_choose_train_car

    if car.passenger?
      puts 'Свободные места:'
      car.free_seats.each { |seat, _is_free| puts seat }

      puts 'Укажите номер места, которое хотите занять:'
      user_input
      car.take_seat(@input.to_i)
    elsif car.cargo?
      puts "Свободно: #{car.free_space}"

      puts 'Укажите объем, который хотите загрузить:'
      user_input
      car.load(@input.to_i)
    end

    @state = STATE_TRAIN_MENU
  end

  def render_train_car_param_del
    car = render_choose_train_car

    if car.passenger?
      puts 'Занятые места места:'
      car.taked_seats.each { |seat, _is_free| puts seat }

      puts 'Укажите номер места, которое хотите освободить:'
      user_input
      car.release_seat(@input.to_i)
    elsif car.cargo?
      puts "Текущий объем: #{car.used_space}"

      puts 'Укажите объем, который хотите выгрузить:'
      user_input
      car.unload(@input.to_i)
    end

    @state = STATE_TRAIN_MENU
  end
end

Controller.new
