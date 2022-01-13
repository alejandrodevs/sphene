# frozen_string_literal: true

module Sphene
  module Types
    class String < Base
      def self.perform(value)
        String(value)
      end
    end
  end
end
