# frozen_string_literal: true

module CarValidator
  REXP_ALLOWED = /^[A-Za-z]{2}-[0-9]{4}$/i.freeze

  private

  def validate!
    raise 'Неверный номер вагона! Укажите номер в латвийском формате {AA-0000}' if num !~ REXP_ALLOWED
  end
end
