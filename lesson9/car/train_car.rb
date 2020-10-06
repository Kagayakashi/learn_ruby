# frozen_string_literal: true

class TrainCar
  include TrainType
  include Author # Модуль производителя.
  # Задается при создании нового вагона
  # Выводится при выборе вагона для прицепки в поезде
  include CarValidator
  include Valid

  attr_reader :num

  def initialize(num, _seats_count)
    @num = num

    validate!
  end
end
