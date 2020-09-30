module TrainValidator
  REXP_ALLOWED = /^[A-Za-z]{2}-[0-9]{4}$/i
  private
  def validate_train!(val = input)
    raise StandardError if val !~ REXP_ALLOWED
  rescue StandardError
    puts "Не правильно введен номер поезда! Требуемый формат {AA-1234}."
    raise RuntimeError
  end
end
