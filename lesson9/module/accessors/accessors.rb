# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |arg|
        # Define variables
        attr_name = "@#{arg}"
        attr_history = "@#{arg}_history"
        method_history = "#{arg}_history"

        # Defined history getter
        define_method(method_history) { instance_variable_get(attr_history) }

        # Define setter for every arg
        define_method("#{arg}=") do |value|
          instance_variable_set(attr_name, value)
          instance_variable_get(attr_history) || instance_variable_set(attr_history, [])
          instance_variable_get(attr_history) << value
        end
      end
      attr_reader(*args)
    end

    def strong_attr_accessor(arg, arg_class)
      attr_reader arg
      define_method("#{arg}=") do |value|
        raise "Значение не является инстансом #{arg_class.name}" unless value.is_a?(arg_class)

        instance_variable_set("@#{arg}", value)
      end
    end
  end
end
