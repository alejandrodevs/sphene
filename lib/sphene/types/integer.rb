module Sphene
  module Types
    class Integer < Base
      def self.perform(value)
        Integer(value)
      end
    end
  end
end
