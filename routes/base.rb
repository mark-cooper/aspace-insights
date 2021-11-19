class ASpaceInsightsApi < Sinatra::Application
  get '/' do
    MultiJson.dump({
                     name: 'ASpace Insights',
                     version: ASpaceInsightsApi::Constants.VERSION
                   })
  end
end
