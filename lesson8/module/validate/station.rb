module StationValidator
  private
  def validate!
    raise "Наименование станции должно содержать от 3 до 20 символов!" if name.length < 3 || name.length > 20
  end
end
