class TrainCar
  include Author #Модуль производителя.
  # Задается при создании нового вагона
  # Выводится при выборе вагона для прицепки в поезде
  
  
  attr_reader :num
  
  def initialize(num)
    @num = num
    welcome
  end

  def welcome
    puts "Создан #{@type} вагон #{@num}."
  end

end
