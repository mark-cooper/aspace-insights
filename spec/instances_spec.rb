require 'spec_helper'

RSpec.describe 'ASpaceInsightsApi instances route' do
  def app
    ASpaceInsightsApi
  end

  it 'accepts incoming payload when token supplied' do
    post "/instances?token=#{ASpaceInsightsApi::Constants.TEST_TOKEN}"
    expect(last_response).to be_ok
    expect(last_response.body).to match('ok') # placeholder
  end

  it 'rejects request when no token is provided' do
    post '/instances'
    expect(last_response).to_not be_ok
    expect(last_response.body).to match(/not authorized/)
  end

  it 'rejects request when incorrect token is provided' do
    post '/instances?token=123456'
    expect(last_response).to_not be_ok
    expect(last_response.body).to match(/not authorized/)
  end
end
