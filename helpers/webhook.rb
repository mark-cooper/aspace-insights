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
    rescue MultiJson::ParseError
      [400, MultiJson.dump({
                             error: 'Invalid payload'
                           })]
    rescue WebhookError => e
      [400, MultiJson.dump({
                             error: e.message
                           })]
    rescue StandardError => e
      [500, MultiJson.dump({
                             error: e.message
                           })]
    end

    def handle_report(event)
      data         = event['data']
      instance     = data['header']
      global       = data['report']['global']
      repositories = data['report']['repository']

      i = create_or_update_instance instance
      create_report(i, global)

      repositories.first.each do |code, report|
        i.repositories << Repository.find_or_create_by(code: code) do |r|
          create_report(r, report)
        end
      end
    end

    def create_or_update_instance(instance)
      i = Instance.find_or_create_by(code: instance['sitecode'])
      instance.delete 'date'
      instance.delete 'sitecode'
      i.update_attributes(instance)
      i
    end

    def create_report(rel, data)
      r = Report.new(data: data, reportable: rel)
      r.save if r.valid?
    end
  end
end
