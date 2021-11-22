class ASpaceInsightsApi < Sinatra::Application
  post '/instances' do
    ASpaceInsightsApi::Webhook.new.handle(request)
    # MultiJson.dump({
    #                  result: 'ok'
    #                })
  end
end
