# frozen_string_literal: true

require 'time'

module Sphene
  module Types
    class Time < Base
      def self.perform(value)
        ::Time.parse(value)
      end
    end
  end
end
