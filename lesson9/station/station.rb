# frozen_string_literal: true

class Station
  include InstanceCounter # Модуль счётчика экземпляров класса
  include StationValidator
  include Valid

  attr_reader :name
  @instances = []

  def initialize(name)
    @name = name

    validate!

    @trains = []
    @@instances << self

    register_instance
  end

  def self.all
    @instances
  end

  def for_each_train
    @trains.each { |train| yield train }
  end

  # По умолчанию вызвать список вагонов, либо произвольный список
  def list(trains = @trains)
    trains
  end

  # Отфильтровать список вагонов по типу и вызвать метод train_list
  def list_with_type(type)
    type_filter = proc { |train| train.type == type }
    list(@trains.select(&type_filter))
  end

  def add(train)
    @trains << train
  end

  def del(train)
    @trains.delete(train)
  end
end
