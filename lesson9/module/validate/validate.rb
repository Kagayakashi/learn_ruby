# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :validation_list

    def to_validation_list(*args)
      self.validation_list ||= []
      validation_list << { variable: args[0], type: args[1], format: args[2] }
    end
  end

  def validate!
    self.class.validation_list.each do |validation|
      value = instance_variable_get("@#{validation[:variable]}".to_sym)

      puts "#{validation[:variable]} = #{value}"

      send("validate_#{validation[:type]}", value, validation[:format])
    end
  end

  def validate_presence(variable, _niu)
    raise 'Значение не может быть пустым.' if variable.nil? || variable.empty?
  end

  def validate_format(variable, regexp)
    raise "Значение не указано в формате #{regexp}." if variable !~ regexp
  end

  def validate_type(variable, base)
    raise "Значение не является экземпляром #{base.name}." unless variable.is_a?(base)
  end
end

class Test
  include Validation
  attr_accessor :x, :y

  to_validation_list :x, :format, /^[A-Za-z]{2}-[0-9]{4}$/i
  to_validation_list :y, :presence
end

test = Test.new
test.x = 'qw-1234'
test.y = '1'
test.validate!
