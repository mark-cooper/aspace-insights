class ASpaceInsightsApi < Sinatra::Application
  class Chart
    def self.by_month(data)
      data.each_with_object({}) do |d, m|
        month = Date::MONTHNAMES[d['month'].to_i]
        m[month] = d['resources']
      end
    end

    def self.by_property(data, property)
      data.each_with_object({}) do |d, m|
        m[d[property]] = d['resources']
      end
    end
  end
end
