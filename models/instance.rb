class Instance < ActiveRecord::Base
  has_many :reports, as: :reportable
  has_many :repositories
  validates_presence_of :code

  def self.basic_report
    self.connection.select_all(
      ASpaceInsightsApi::Queries.instance_report_basic
    ).to_hash
  end

  def self.full_report
    self.connection.select_all(
      ASpaceInsightsApi::Queries.instance_report_full
    ).to_hash
  end
end
