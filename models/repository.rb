class Repository < ActiveRecord::Base
  belongs_to :instance
  has_many :reports, as: :reportable
  validates_presence_of :code
end
