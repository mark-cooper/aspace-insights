class ASpaceInsightsApi < Sinatra::Application
  class Token
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def valid?
      return false if empty?
      return false if too_short?

      true
    end

    def empty?
      return true if token.nil? || token.empty?
    end

    def too_short?
      return true if token.length < ASpaceInsightsApi::Constants.TOKEN_MIN_LENGTH
    end
  end
end
