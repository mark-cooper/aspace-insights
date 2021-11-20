class ASpaceInsightsApi < Sinatra::Application
  post '/instances' do
    MultiJson.dump({
                     result: 'ok'
                   })
  end
end
