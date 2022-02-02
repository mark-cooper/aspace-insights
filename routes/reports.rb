class ASpaceInsightsApi < Sinatra::Application
  get '/reports' do
    content_type :html
    @report = Instance.full_report
    @report.each do |i|
      i['chart_resources'] = if i['resources'].to_i > ASpaceInsightsApi::Constants.REPORT_LARGE_TIER
                               ASpaceInsightsApi::Constants.REPORT_LARGE_TIER
                             else
                               i['resources'].to_i
                             end
    end
    erb :'reports.index.html', layout: :'layout.html'
  end

  get '/reports/instances/:i_code' do
    content_type :html
    @instance = Instance.where(code: params[:i_code]).first
    pass unless @instance

    erb :'instance.html', layout: :'layout.html'
  end

  get '/reports/instances/:i_code/repositories' do
    content_type :html
  end

  get '/reports/instances/:i_code/repositories/:r_code' do
    content_type :html
  end
end
