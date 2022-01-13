# frozen_string_literal: true

require "date"

module Sphene
  module Types
    class Date < Base
      def self.perform(value)
        ::Date.parse(value)
      end
    end
  end
end
