require 'multi_json'
require 'sinatra'
require 'sinatra/config_file'

%w[helpers models routes].each do |dir|
  $LOAD_PATH << File.expand_path('.', File.join(File.dirname(__FILE__), dir))
  require_relative File.join(dir, 'init')
end

Sinatra::Application.config_file(
  File.join(File.dirname(__FILE__), 'config', 'config.yml.erb')
)

class ASpaceInsightsApi < Sinatra::Application
  configure do
    unless ASpaceInsightsApi::Token.new(settings.token).valid?
      raise 'Invalid app token, cannot startup.'
    end
  end

  before do
    authenticate!
  end

  run! if app_file == $0
end
