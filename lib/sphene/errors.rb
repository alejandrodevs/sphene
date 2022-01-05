# frozen_string_literal: true

module Sphene
  class InvalidAttributeNameError < StandardError
    def initialize(attribute)
      super("Invalid attribute name #{attribute}")
    end
  end
end
