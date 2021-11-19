require 'multi_json'
require 'sinatra'
require 'sinatra/config_file'

Sinatra::Application.config_file(
  File.join(File.dirname(__FILE__), 'config', 'config.yml.erb')
)

%w[helpers models routes].each do |dir|
  $LOAD_PATH << File.expand_path('.', File.join(File.dirname(__FILE__), dir))
  require_relative File.join(dir, 'init')
end

class ASpaceInsightsApi < Sinatra::Application
  before do
    authenticate!
  end

  run! if app_file == $0
end
