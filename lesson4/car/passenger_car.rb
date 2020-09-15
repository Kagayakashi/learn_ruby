class PassengerCar < TrainCar
  attr_reader :type
  def initialize(num)
    @type = "Пассажирский"
    super
  end

end 
