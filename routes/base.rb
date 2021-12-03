class ASpaceInsightsApi < Sinatra::Application
  get '/' do
    [200, MultiJson.dump({
                           name: 'ASpace Insights',
                           version: ASpaceInsightsApi::Constants.VERSION
                         })]
  end

  get '/ping' do
    [200, MultiJson.dump({ message: 'Ok!' })]
  end
end
