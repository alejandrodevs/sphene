# frozen_string_literal: true

require "sphene/types"
require "sphene/errors"

module Sphene
  module Attributes
    Types = Sphene::Types

    def initialize(attrs = {})
      initialize_attributes
      assign_attributes(attrs)
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def read_attribute(name)
      ensure_attribute(name) do |name|
        @attributes[name].value
      end
    end

    def write_attribute(name, value)
      ensure_attribute(name) do |name|
        @attributes[name].value = value
      end
    end

    def assign_attributes(attrs)
      attrs.each do |name, value|
        write_attribute(name, value)
      end
    end

    def attributes
      @attributes.to_hash
    end

    private

    def initialize_attributes
      @attributes = AttributeSet.from(self.class)
    end

    def ensure_attribute(name)
      assert_attribute(name)
      yield(name.to_sym) if block_given?
    end

    def assert_attribute(name)
      unless @attributes.key?(name.to_sym)
        raise InvalidAttributeNameError.new(name)
      end
    end

    module ClassMethods
      def attribute(name, type, options = {})
        name = name.to_sym
        options[:type] = type
        attributes[name] = options
        define_attribute_setter_method(name)
        define_attribute_getter_method(name)
      end

      def inherited(base)
        base.instance_variable_set(:@attributes, attributes.dup)
      end

      def attributes
        @attributes ||= Hash.new({})
      end

      private

      def define_attribute_getter_method(name)
        define_method(name) do
          read_attribute(name)
        end
      end

      def define_attribute_setter_method(name)
        define_method(:"#{name}=") do |value|
          write_attribute(name, value)
        end
      end
    end
  end
end
