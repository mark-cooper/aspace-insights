class ASpaceInsightsApi < Sinatra::Application
  class Chart
    def self.by_month(data, property = 'resources')
      data.each_with_object({}) do |d, m|
        month = Date::MONTHNAMES[d['month'].to_i]
        m[month] = d[property]
      end
    end

    def self.by_property(data, label, property = 'resources')
      data.sort_by { |r| r[property].to_i }.reverse.each_with_object({}) do |d, m|
        m[d[label]] = d[property]
      end
    end
  end
end
