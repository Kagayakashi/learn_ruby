module StationValidator
  private
  def validate_station!(val = input)
    raise StandardError if val.length < 3 || val.length > 20
  rescue StandardError
    puts "Не правильно введено наименование станции! Наименование должно содержать от 3 до 20 символов."
    raise RuntimeError
  end
end
