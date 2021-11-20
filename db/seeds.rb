if ENV.fetch('RACK_ENV', 'development') == 'development'
  instance = Instance.find_or_create_by(name: 'Test') do |i|
    i.reports << Report.create
  end
  instance.repositories << Repository.find_or_create_by(name: 'Test Repo 1') do |r|
    r.reports << Report.create
  end
  instance.repositories << Repository.find_or_create_by(name: 'Test Repo 2') do |r|
    r.reports << Report.create
  end
end
