class PassengerCar < TrainCar
  
  SEAT_FREE = false
  SEAT_IN_USE = true
  
  def initialize(num, seats_count)
    @seats = {}
    
    create_seats(seats_count)
    
    super
  end
  
  def create_seats(amount)
    amount.times.with_index(1) {|i| @seats[i] = SEAT_FREE}
  end

  def take_seat(i)
    @seats[i] = SEAT_IN_USE
  end
  
  def release_seat(i)
    @seats[i] = SEAT_FREE
  end
  
  def free_seats
    @seats.select {|k, v| v == SEAT_FREE}
  end
  
  def taked_seats
    @seats.select {|k, v| v == SEAT_IN_USE}
  end
  
end
