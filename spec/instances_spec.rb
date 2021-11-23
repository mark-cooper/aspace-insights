require 'spec_helper'

RSpec.describe 'ASpaceInsightsApi instances route' do
  def app
    ASpaceInsightsApi
  end

  let(:payload) { JSON.parse(File.read(File.join(RSPEC_ROOT, 'fixtures', 'report.json'))) }
  let(:payload_invalid) { '{ "type": "report", xyx"data": {} }' }
  let(:payload_invalid_type) { { type: 'unknown', data: {} } }

  it 'accepts incoming payload when token supplied' do
    post "/instances?token=#{ASpaceInsightsApi::Constants.TEST_TOKEN}", JSON.generate(payload)
    expect(last_response).to be_ok
    expect(last_response.body).to match('accepted')
  end

  it 'rejects incoming payload when payload is invalid' do
    post "/instances?token=#{ASpaceInsightsApi::Constants.TEST_TOKEN}", payload_invalid
    expect(last_response).to_not be_ok
    expect(last_response.body).to match('Invalid payload')
  end

  it 'rejects incoming payload when type is unrecognized' do
    post "/instances?token=#{ASpaceInsightsApi::Constants.TEST_TOKEN}", JSON.generate(payload_invalid_type)
    expect(last_response).to_not be_ok
    expect(last_response.body).to match('not recognized')
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
