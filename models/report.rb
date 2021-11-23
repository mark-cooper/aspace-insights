class Report < ActiveRecord::Base
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :reportable, polymorphic: true
  validates :checksum, uniqueness: { scope: [:month, :reportable_id] }

  def set_defaults
    self.checksum = Digest::SHA2.hexdigest(data.to_s)
    self.month    = DateTime.now.month
  end
end
