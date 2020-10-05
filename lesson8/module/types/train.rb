# frozen_string_literal: true

module TrainType
  def type
    return 'Пасажирский' if is_passenger

    'Грузовой' if is_cargo
  end

  def passenger?
    return true if instance_of?(PassengerTrain) || instance_of?(PassengerCar)

    false
  end

  def cargo?
    return true if instance_of?(CargoTrain) || instance_of?(CargoCar)

    false
  end
end
