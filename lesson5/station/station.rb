class Station
  include InstanceCounter # Модуль счётчика экземпляров класса
  
  attr_reader :name
  @@instances = []

  def initialize(name)
    @name = name
    @trains = []
    @@instances << self

    register_instance
    welcome
  end

  def self.all
    @@instances
  end

  def welcome
    puts "Создана станция #{@name}!"
    puts "Создано #{self.class.instances} экземпляра станции."
  end

  # По умолчанию вызвать список вагонов, либо произвольный список
  def list(trains = @trains)
    puts "\nСписок поездов на станции:"
    trains.each {|train| puts "Поезд #{train.type} - #{train.num}, #{train.cars.count} вагонов."}
  end
  
  # Отфильтровать список вагонов по типу и вызвать метод train_list
  def list_with_type(type)
    type_filter = proc {|train| train.type == type}
    list(@trains.select(&type_filter))
  end

  def add(train)
    @trains << train
    puts "\nПоезд - #{train.num} приехал на станцию #{@name}."
  end

  def del(train)
    @trains.delete(train)
    puts "\nПоезд - #{train.num} отправлен."
  end

end
