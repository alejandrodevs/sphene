# frozen_string_literal: true

module Sphene
  class Attribute
    attr_reader :name, :model, :type, :default

    def initialize(name, model, type: Types::Default, default: nil)
      @name = name
      @model = model
      @type = type
      @default = default
    end

    def value
      return default_value unless ivar_defined?(:@value_before_cast)
      return @value if ivar_defined?(:@value)
      @value = type.cast(@value_before_cast)
    end

    def value=(value)
      remove_ivar(:@value) if ivar_defined?(:@value)
      @value_before_cast = value
    end

    private

    def default_value
      default.respond_to?(:call) ? default.call(model) : default
    end

    def ivar_defined?(name)
      instance_variable_defined?(name)
    end

    def remove_ivar(name)
      remove_instance_variable(name)
    end
  end
end
