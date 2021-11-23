class Report < ActiveRecord::Base
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :reportable, polymorphic: true
  validates :checksum, uniqueness: { scope: %i[day month year reportable_id reportable_type] }

  scope :by_instance, -> { where(reportable_type: 'Instance') }
  scope :by_month, ->(month) { where(month: month) }
  scope :by_repository, -> { where(reportable_type: 'Repository') }

  def set_defaults
    self.checksum = Digest::SHA2.hexdigest(data.to_s)
    self.day   ||= DateTime.now.day
    self.month ||= DateTime.now.month
    self.year  ||= DateTime.now.year
  end
end
