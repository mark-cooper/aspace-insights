class Repository < ActiveRecord::Base
  belongs_to :instance
  has_many :reports, as: :reportable
end
