class Repository < ActiveRecord::Base
  belongs_to :instance
  has_many :reports, as: :reportable
  validates_presence_of :code

  def self.basic_report
    self.connection.select_all(
      ASpaceInsightsApi::Queries.repository_report_basic
    ).to_hash
  end
end
