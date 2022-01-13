# frozen_string_literal: true

require "delegate"

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

    def to_hash
      each.with_object({}) do |(name, attribute), data|
        data[name] = attribute.value
      end
    end
  end
end
