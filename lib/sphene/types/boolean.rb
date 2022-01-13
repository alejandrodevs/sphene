# frozen_string_literal: true

module Sphene
  module Types
    class Boolean < Base
      def self.perform(value)
        !!value
      end
    end
  end
end
