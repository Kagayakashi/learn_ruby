module TrainType

  def type
    return "Пасажирский" if is_passenger
    "Грузовой" if is_cargo
  end
  
  def is_passenger
    return true if self.instance_of?(PassengerTrain) || self.instance_of?(PassengerCar)
    false
  end
  
  def is_cargo
    return true if self.instance_of?(CargoTrain) || self.instance_of?(CargoCar)
    false
  end

end
