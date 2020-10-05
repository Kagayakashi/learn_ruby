# frozen_string_literal: true

class CargoCar < TrainCar
  def initialize(num, volume)
    @max_volume = volume
    @current_volume = 0

    super
  end

  def load(volume)
    @current_volume += volume if free_space >= volume
  end

  def free_space
    @max_volume - @current_volume
  end

  def used_space
    @current_volume
  end
end
