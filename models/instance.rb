class Instance < ActiveRecord::Base
  has_many :reports, as: :reportable
  has_many :repositories
  validates_presence_of :code

  def self.basic_report
    connection.select_all(
      ASpaceInsightsApi::Queries.instance_report_basic
    ).to_hash
  end

  def self.daily_report_by_month(code, month)
    connection.select_all(
      ASpaceInsightsApi::Queries.instance_daily_by_month(code, month)
    ).to_hash
  end

  def self.full_report
    connection.select_all(
      ASpaceInsightsApi::Queries.instance_report_full
    ).to_hash
  end

  def self.monthly_report(code)
    connection.select_all(
      ASpaceInsightsApi::Queries.instance_monthly_all_years(code)
    ).to_hash
  end

  def self.monthly_report_by_year(code, year)
    connection.select_all(
      ASpaceInsightsApi::Queries.instance_monthly_by_year(code, year)
    ).to_hash
  end
end
