class ASpaceInsightsApi < Sinatra::Application
  class WebhookError < StandardError
  end

  class Webhook
    def handle(request)
      event  = MultiJson.load(request.body.read)
      method = "handle_#{event['type'].gsub('.', '_')}"
      send method, event
      [200, MultiJson.dump({
                             message: 'Webhook accepted'
                           })]
    rescue JSON::ParserError
      [400, MultiJson.dump({
                             error: 'Invalid payload'
                           })]
    rescue NoMethodError
      [400, MultiJson.dump({
                             error: "Webhook not recognized: #{event['type']}"
                           })]
    rescue WebhookError => e
      [500, MultiJson.dump({
                             error: e.message
                           })]
    end

    def handle_report(event)
      puts event.inspect
    end
  end
end
