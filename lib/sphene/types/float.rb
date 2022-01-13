# frozen_string_literal: true

module Sphene
  module Types
    class Float < Base
      def self.perform(value)
        Float(value)
      end
    end
  end
end
