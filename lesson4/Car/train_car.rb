class TrainCar

  attr_reader :num
  
  def initialize(num)
    @num = num
    welcome
  end

  def welcome
    puts "Создан #{@type} вагон #{@num}."
  end

end
