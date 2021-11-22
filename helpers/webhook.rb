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
      [400, MultiJson.dump({
                             error: e.message
                           })]
    end

    def handle_report(event)
      data        = event['data']
      # instance    = data['header']
      # global      = data['report']['global']
      # repoitories = data['report']['repository']
      # i = Instance.find_or_create_by(sitecode: instance['sitecode'])
      # i.update_attributes(MultiJson.load(instance))
      # i.reports << Report.create(MultiJson.load(global))
      # repoitories.each do |code, report|
      #   i.repositories << Repository.find_or_create_by(code: code) do |r|
      #     r.reports << Report.create(MultiJson.load(report))
      #   end
      # end
    end
  end
end
