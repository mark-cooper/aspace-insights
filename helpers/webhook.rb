class ASpaceInsightsApi < Sinatra::Application
  class WebhookError < StandardError
  end

  class Webhook
    def handle(request)
      event   = MultiJson.load(request.body.read)
      handler = "handle_#{event['type'].gsub('.', '_')}"
      raise WebhookError, "Webhook not recognized: #{handler}" unless respond_to?(handler.to_sym)

      send handler, event
      [200, MultiJson.dump({
                             message: 'Webhook accepted'
                           })]
    rescue JSON::ParserError
      [400, MultiJson.dump({
                             error: 'Invalid payload'
                           })]
    rescue WebhookError => e
      [500, MultiJson.dump({
                             error: e.message
                           })]
    end

    def handle_report(event)
      data     = event['data']
      # instance = data['header']
      # global   = data['report']['global']
      # repo     = data['report']['repository']
      puts data.inspect
    end
  end
end
