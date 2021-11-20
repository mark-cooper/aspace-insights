module Sinatra
  module Authentication
    def authenticate!
      return true if valid_token?

      unless authenticated?
        halt 401, MultiJson.dump(
          { message: 'You are not authorized to access this resource' }
        )
      end
    end

    def authenticated?
      valid_token?
    end

    def valid_token?
      request_token = ASpaceInsightsApi::Token.new(request['token'].to_s)
      app_token     = ASpaceInsightsApi::Token.new(settings.token.to_s)

      unless request_token.valid?
        log.error "Request token is invalid: #{request_token.errors}"
        return false
      end

      unless app_token.valid?
        log.error "App token is invalid: #{app_token.errors}"
        return false
      end

      request_token.token == app_token.token
    end
  end

  helpers Authentication
end
