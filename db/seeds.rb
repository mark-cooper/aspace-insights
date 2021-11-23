if ENV.fetch('RACK_ENV', 'development') == 'development'
  instance = Instance.find_or_create_by(code: 'test') do |i|
    i.reports << Report.create(data: { resources: 3 })
  end
  instance.repositories << Repository.find_or_create_by(code: 'test_repo_1') do |r|
    r.reports << Report.create(data: { resources: 1 })
  end
  instance.repositories << Repository.find_or_create_by(code: 'test_repo_2') do |r|
    r.reports << Report.create(data: { resources: 2 })
  end

  # simulate some duplications and additions
  Report.create(data: { resources: 3 }, reportable: instance)         # reject
  Report.create(data: { resources: 1 }, reportable: Repository.first) # reject
  Report.create(data: { resources: 2 }, reportable: Repository.first) # accept
  Report.create(data: { resources: 2 }, reportable: Repository.last)  # reject
  Report.create(data: { resources: 3 }, reportable: Repository.last)  # accept
  Report.create(data: { resources: 5 }, reportable: instance)         # accept
end
