require_relative '../main'
require 'database_cleaner/active_record'
require 'rspec'
require 'rack/test'
require 'shoulda/matchers'

ENV['RACK_ENV'] = 'test'
RSPEC_ROOT = File.dirname __FILE__

DatabaseCleaner.strategy = :truncation

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end

shared_examples 'reportable' do
  it { is_expected.to have_many(:reports) }
end
