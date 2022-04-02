# frozen_string_literal: true

require "delegate"

module Sphene
  class AttributeSet < SimpleDelegator
    attr_reader :model

    def initialize(model)
      @model = model
      super({})
    end

    def self.from(model)
      new(model).tap do |data|
        model.class.attributes.each do |name, options|
          data[name] = Attribute.new(name, model, **options)
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
