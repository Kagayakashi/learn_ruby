class CargoCar < TrainCar
  attr_reader :type
  def initialize(num)
    @type = "Грузовой"
    super
  end

end 
 