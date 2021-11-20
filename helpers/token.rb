class ASpaceInsightsApi < Sinatra::Application
  class Token
    attr_reader :errors, :token

    def initialize(token)
      @errors = []
      @token  = token
    end

    def valid?
      empty?
      too_short?
      return false if @errors.any?

      true
    end

    def empty?
      @errors << 'Token is empty' if token.nil? || token.empty?
    end

    def too_short?
      min = ASpaceInsightsApi::Constants.TOKEN_MIN_LENGTH
      len = token.to_s.length
      @errors << "Token is too short [#{len}], must be at least [#{min}]" if len < min
    end
  end
end
