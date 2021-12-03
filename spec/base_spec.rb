require 'spec_helper'

RSpec.describe 'ASpaceInsightsApi base route' do
  def app
    ASpaceInsightsApi
  end

  it 'displays app information when token supplied' do
    get "/?token=#{ASpaceInsightsApi::Constants.TEST_TOKEN}"
    expect(last_response).to be_ok
    expect(last_response.body).to match(ASpaceInsightsApi::Constants.VERSION)
  end

  it 'rejects request when no token is provided' do
    get '/'
    expect(last_response).to_not be_ok
    expect(last_response.body).to match(/not authorized/)
  end

  it 'rejects request when incorrect token is provided' do
    get '/?token=123456'
    expect(last_response).to_not be_ok
    expect(last_response.body).to match(/not authorized/)
  end

  it 'accepts a request to the health check path without token' do
    get '/ping'
    expect(last_response).to be_ok
    expect(last_response.body).to match('Ok!')
  end
end
