class Instance < ActiveRecord::Base
  has_many :reports, as: :reportable
  has_many :repositories
  validates_presence_of :name
end
