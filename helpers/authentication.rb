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

    def valid_token?
      request_token = ASpaceInsightsApi::Token.new(request['token'].to_s)
      app_token     = ASpaceInsightsApi::Token.new(settings.token.to_s)

      return false unless request_token.valid?
      return false unless app_token.valid?

      request_token.token == app_token.token
    end
  end

  helpers Authentication
end
