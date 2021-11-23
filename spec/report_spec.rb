require 'spec_helper'
require 'securerandom'

RSpec.describe Report, type: :model do
  it { is_expected.to have_db_column(:reportable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:reportable_type).of_type(:string) }
  it { is_expected.to belong_to(:reportable) }

  context 'Adding a report to an instance' do
    let(:instance) { Instance.create(code: SecureRandom.uuid) }
    let(:data1) { { resources: 1 } }
    let(:data2) { { resources: 2 } }

    it 'can add a new report but will not duplicate the same report' do
      r = Report.new(data: data1, reportable: instance)
      expect(r).to be_valid
      r.save
      expect(instance.reports.count).to eq 1

      r = Report.new(data: data1, reportable: instance)
      expect(r).to_not be_valid

      r = Report.new(data: data2, reportable: instance)
      expect(r).to be_valid
      r.save
      expect(instance.reports.count).to eq 2
    end
  end

  context 'Adding a report to a repository' do
    let(:instance) { Instance.create(code: SecureRandom.uuid) }
    let(:repository1) { Repository.create(code: SecureRandom.uuid, instance: instance) }
    let(:repository2) { Repository.create(code: SecureRandom.uuid, instance: instance) }
    let(:data1) { { resources: 1 } }
    let(:data2) { { resources: 2 } }

    it 'can add a new report but will not duplicate the same report scoped by repository' do
      r = Report.new(data: data1, reportable: repository1)
      expect(r).to be_valid
      r.save
      expect(repository1.reports.count).to eq 1

      r = Report.new(data: data1, reportable: repository1)
      expect(r).to_not be_valid

      r = Report.new(data: data2, reportable: repository1)
      expect(r).to be_valid
      r.save
      expect(repository1.reports.count).to eq 2

      # repeat for repository 2
      r = Report.new(data: data1, reportable: repository2)
      expect(r).to be_valid
      r.save
      expect(repository2.reports.count).to eq 1

      r = Report.new(data: data1, reportable: repository2)
      expect(r).to_not be_valid

      r = Report.new(data: data2, reportable: repository2)
      expect(r).to be_valid
      r.save
      expect(repository2.reports.count).to eq 2
    end
  end
end
