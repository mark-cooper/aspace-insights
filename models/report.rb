class Report < ActiveRecord::Base
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :reportable, polymorphic: true

  def set_defaults
    self.month = DateTime.now.month
  end
end
