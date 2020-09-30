module CarValidator
  REXP_ALLOWED = /^[A-Za-z]{2}-[0-9]{4}$/i
  private
  def validate_car!(val = input)
    raise StandardError if val !~ REXP_ALLOWED
  rescue StandardError
    puts "Не правильно введен номер вагона! Требуемый формат {AA-1234}."
    raise RuntimeError
  end 
end
