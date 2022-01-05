# frozen_string_literal: true

require 'delegate'

module Sphene
  class AttributeSet < SimpleDelegator
    attr_reader :object

    def initialize(object)
      @object = object
      super({})
    end

    def self.from(object)
      new(object).tap do |data|
        object.attributes.each do |name, options|
          data[name] = Attribute.new(name, **options)
        end
      end
    end
  end
end
