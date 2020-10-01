class PassengerTrain < Train
  attr_reader :type
  
  def initialize(num)
    @type = "Пассажирский"
    super
  end

end
