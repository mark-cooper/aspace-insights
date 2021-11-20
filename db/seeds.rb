if ENV.fetch('RACK_ENV', 'development') == 'development'
  Instance.find_or_create_by(name: 'Test')
  # TODO
end
