require 'spec_helper'

RSpec.describe 'ASpaceInsightsApi Token' do
  it 'accepts token when valid' do
    token = ASpaceInsightsApi::Token.new(ASpaceInsightsApi::Constants.TEST_TOKEN)
    expect(token.valid?).to be true
    expect(token.errors).to be_empty
  end

  it 'rejects token when empty' do
    token = ASpaceInsightsApi::Token.new('')
    expect(token.valid?).to be false
    expect(token.errors[0]).to match(/empty/)
  end

  it 'rejects token when nil' do
    token = ASpaceInsightsApi::Token.new(nil)
    expect(token.valid?).to be false
    expect(token.errors[0]).to match(/empty/)
  end

  it 'rejects token when too short' do
    token = ASpaceInsightsApi::Token.new('123')
    expect(token.valid?).to be false
    expect(token.errors[0]).to match(/too short/)
  end
end
