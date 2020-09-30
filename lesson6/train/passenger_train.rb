class PassengerTrain < Train
  attr_reader :type
    def initialize(num, valid)
    @type = "Пассажирский"
    super
  end

end
