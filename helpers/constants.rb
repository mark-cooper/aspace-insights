class ASpaceInsightsApi < Sinatra::Application
  module Constants
    def self.DEVELOPMENT_TOKEN
      '01609d9cc98201a9c859dece3035e19d'
    end

    def self.HEALTH_CHECK_PATH
      '/ping'
    end

    def self.TEST_TOKEN
      '01609d9cc98201a9c859dece3035e19d'
    end

    def self.TOKEN_MIN_LENGTH
      12
    end

    def self.VERSION
      '0.1.0'.freeze
    end
  end
end
