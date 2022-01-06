module Sphene
  module Types
    class Symbol < Base
      def self.perform(value)
        value.to_sym
      end
    end
  end
end
