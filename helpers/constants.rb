class ASpaceInsightsApi < Sinatra::Application
  module Constants
    def self.DEVELOPMENT_TOKEN
      '01609d9cc98201a9c859dece3035e19d'
    end

    def self.TEST_TOKEN
      '01609d9cc98201a9c859dece3035e19d'
    end

    def self.title
      'ArchivesSpace Insights API'
    end

    def self.REPORT_LARGE_TIER
      1000
    end

    def self.TOKEN_MIN_LENGTH
      12
    end

    def self.UNAUTHENTICATED_ENDPOINTS
      [
        '/ping'
      ]
    end

    def self.VERSION
      '0.1.0'.freeze
    end
  end
end
