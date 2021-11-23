class Instance < ActiveRecord::Base
  has_many :reports, as: :reportable
  has_many :repositories
  validates_presence_of :code

  def self.report
    Instance.order(:code).all.each do |i|
      i.reports.order('created_at DESC').limit(1).each do |r|
        puts r.data['resources']
      end
    end
  end
end
