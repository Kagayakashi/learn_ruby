class CargoTrain < Train
  attr_reader :type
  
  def initialize(num, valid)
    @type = "Грузовой"
    super
  end

end
