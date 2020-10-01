class CargoTrain < Train
  attr_reader :type
  
  def initialize(num)
    @type = "Грузовой"
    super
  end

end
