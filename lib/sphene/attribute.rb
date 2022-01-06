module Sphene
  class Attribute
    attr_reader :name, :type, :default

    def initialize(name, type: Types::Default, default: nil)
      @name = name
      @type = type
      @default = default
    end

    def value
      return default if !iv_defined?(:@value_before_cast)
      return @value if iv_defined?(:@value)
      @value = type.cast(value_to_cast)
    end

    def value=(value)
      remove_instance_variable(:@value) if iv_defined?(:@value)
      @value_before_cast = value
    end

    private

    def value_to_cast
      iv_defined?(:@value_before_cast) ?
        @value_before_cast : default
    end

    def iv_defined?(name)
      instance_variable_defined?(name)
    end
  end
end
