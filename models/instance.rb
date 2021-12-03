class Instance < ActiveRecord::Base
  has_many :reports, as: :reportable
  has_many :repositories
  validates_presence_of :code

  def report
    as_json(
      except: %i[id created_at updated_at],
      include: { reports: { only: %i[data day month year] } }
    )
  end

  def self.report
    report = []
    Instance.order(:code).all.each do |i|
      report << i.report
    end
    report
  end
end
