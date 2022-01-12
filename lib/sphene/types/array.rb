module Sphene
  module Types
    class Array < Base
      def self.perform(value)
        Array(value)
      end
    end
  end
end
