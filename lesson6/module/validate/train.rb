module TrainValidator
  REXP_ALLOWED = /^[A-Za-z]{2}-[0-9]{4}$/i
  private
  def validate!
    raise RuntimeError if num !~ REXP_ALLOWED
  end
end
