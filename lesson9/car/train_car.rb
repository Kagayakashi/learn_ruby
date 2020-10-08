# frozen_string_literal: true

class TrainCar
  include TrainType
  include Author # Модуль производителя.
  # Задается при создании нового вагона
  # Выводится при выборе вагона для прицепки в поезде
  include Validation

  attr_reader :num
  to_validation_list :num, :format, /^[A-Za-z]{2}-[0-9]{4}$/i

  def initialize(num, _seats_count)
    @num = num

    validate!
  end
end
