module Sinatra
  module Authentication
    def authenticate!
      return true if valid_token?

      halt 401, MultiJson.dump(
        { message: 'You are not authorized to access this resource' }
      ) unless authenticated?
    end

    def authenticated?
      valid_token?
    end

    # TODO test
    def valid_token?
      token = request['token'].to_s

      return false unless token
      return false unless token.length.positive?
      return false unless token.length >= ASpaceInsightsApi::Constants.TOKEN_MIN_LENGTH
      return false if settings.token.nil?

      request['token'] == settings.token
    end
  end

  helpers Authentication
end
