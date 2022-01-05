module Sphene
  module Types
    class Base
      def self.cast(value)
        return if value.nil?
        perform(value)
      end
    end
  end
end
