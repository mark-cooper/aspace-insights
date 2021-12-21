class ASpaceInsightsApi < Sinatra::Application
  get '/reports' do
    content_type :html
    @report = Instance.full_report
    erb :'reports.index.html', layout: :'layout.html'
  end

  get '/reports/instances/:i_code' do
    content_type :html
  end

  get '/reports/instances/:i_code/repositories' do
    content_type :html
  end

  get '/reports/instances/:i_code/repositories/:r_code' do
    content_type :html
  end
end
