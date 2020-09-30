module StationValidator
  private
  def validate!
    raise if name.length < 3 || name.length > 20
  end
end
