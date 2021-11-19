class ASpaceInsightsApi < Sinatra::Application
  module Constants
    def self.TOKEN_MIN_LENGTH
      12
    end

    def self.VERSION
      '0.1.0'.freeze
    end
  end
end
