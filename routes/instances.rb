class ASpaceInsightsApi < Sinatra::Application
  post '/instances' do
    ASpaceInsightsApi::Webhook.new.handle(request)
  end
end
