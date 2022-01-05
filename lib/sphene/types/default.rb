module Sphene
  module Types
    class Default < Base
      def self.cast(value)
        value
      end
    end
  end
end
