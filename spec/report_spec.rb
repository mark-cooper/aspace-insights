require 'spec_helper'
require 'securerandom'

RSpec.describe Report, type: :model do
  it { is_expected.to have_db_column(:reportable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:reportable_type).of_type(:string) }
  it { is_expected.to belong_to(:reportable) }

  context 'Adding a report' do
    context 'to an instance' do
      let(:instance)     { Instance.create(code: SecureRandom.uuid) }
      let(:report1)      { Report.new(day: 1, month: 1, year: 2021, data: { resources: 1 }, reportable: instance) }
      let(:report1_dupe) { Report.new(day: 1, month: 1, year: 2021, data: { resources: 1 }, reportable: instance) }
      let(:report1_next) { Report.new(day: 2, month: 1, year: 2021, data: { resources: 1 }, reportable: instance) }
      let(:report2)      { Report.new(day: 1, month: 2, year: 2021, data: { resources: 1 }, reportable: instance) }

      it 'can add a new report but will not duplicate the same report' do
        expect(report1).to be_valid
        expect(report1.reportable_type).to eq 'Instance'
        report1.save
        expect(instance.reports.count).to eq 1

        expect(report1_dupe).to_not be_valid
        expect(report1_next).to be_valid
        expect(report1_next.reportable_type).to eq 'Instance'
        report1_next.save

        expect(report2).to be_valid
        expect(report2.reportable_type).to eq 'Instance'
        report2.save
        expect(instance.reports.count).to eq 3
      end
    end

    context 'to a repository' do
      let(:instance)        { Instance.create(code: SecureRandom.uuid) }
      let(:repository1)     { Repository.create(code: SecureRandom.uuid, instance: instance) }
      let(:repository2)     { Repository.create(code: SecureRandom.uuid, instance: instance) }
      let(:r1_report1)      { Report.new(day: 1, month: 1, year: 2021, data: { resources: 1 }, reportable: repository1) }
      let(:r1_report1_dupe) { Report.new(day: 1, month: 1, year: 2021, data: { resources: 1 }, reportable: repository1) }
      let(:r1_report2)      { Report.new(day: 1, month: 2, year: 2021, data: { resources: 1 }, reportable: repository1) }
      let(:r2_report1)      { Report.new(day: 1, month: 1, year: 2021, data: { resources: 1 }, reportable: repository2) }
      let(:r2_report1_dupe) { Report.new(day: 1, month: 1, year: 2021, data: { resources: 1 }, reportable: repository2) }
      let(:r2_report2)      { Report.new(day: 1, month: 2, year: 2021, data: { resources: 1 }, reportable: repository2) }

      it 'can add a new report but will not duplicate the same report scoped by repository' do
        expect(r1_report1).to be_valid
        expect(r1_report1.reportable_type).to eq 'Repository'
        r1_report1.save
        expect(repository1.reports.count).to eq 1

        expect(r1_report1_dupe).to_not be_valid

        expect(r1_report2).to be_valid
        expect(r1_report2.reportable_type).to eq 'Repository'
        r1_report2.save
        expect(repository1.reports.count).to eq 2

        # and for r2
        expect(r2_report1).to be_valid
        expect(r2_report1.reportable_type).to eq 'Repository'
        r2_report1.save
        expect(repository2.reports.count).to eq 1

        expect(r2_report1_dupe).to_not be_valid

        expect(r2_report2).to be_valid
        expect(r2_report2.reportable_type).to eq 'Repository'
        r2_report2.save
        expect(repository2.reports.count).to eq 2
      end
    end
  end
end
