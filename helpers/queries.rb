class ASpaceInsightsApi < Sinatra::Application
  module Queries
    def self.instance_daily_by_month(code, month, year = Date.today.year)
      code  = ActiveRecord::Base.connection.quote(code)
      year  = ActiveRecord::Base.connection.quote(year)
      month = ActiveRecord::Base.connection.quote(month)
      "
      SELECT
        day,
        r.data->>'resource' AS resources
      FROM instances i
      JOIN reports r ON r.reportable_id = i.id
      WHERE r.reportable_type = 'Instance'
      AND r.month = #{month}
      AND r.year = #{year}
      AND i.code = #{code};
      "
    end

    def self.instance_monthly_all_years(code)
      code = ActiveRecord::Base.connection.quote(code)
      "
      SELECT DISTINCT ON (year, month)
        year,
        month,
        r.data->>'resource' AS resources
      FROM instances i
      JOIN reports r ON r.reportable_id = i.id
      WHERE r.reportable_type = 'Instance'
      AND i.code = #{code}
      ORDER BY year, month, resources DESC;
      "
    end

    def self.instance_monthly_by_year(code, year)
      code = ActiveRecord::Base.connection.quote(code)
      year = ActiveRecord::Base.connection.quote(year)
      "
      SELECT DISTINCT ON (year, month)
        year,
        month,
        r.data->>'resource' AS resources
      FROM instances i
      JOIN reports r ON r.reportable_id = i.id
      WHERE r.reportable_type = 'Instance'
      AND r.year = #{year}
      AND i.code = #{code}
      ORDER BY month, resources DESC;
      "
    end

    def self.instance_report_basic
      "
      SELECT DISTINCT ON (x.code)
        x.code,
        LEFT(x.name, 75) as name,
        r.year,
        r.month,
        r.day,
        r.data->>'resource' AS resources,
        r.data->>'user_last_mtime' AS last_login
      FROM reports r
      JOIN instances x on r.reportable_id = x.id
      AND r.reportable_type = 'Instance'
      ORDER BY x.code, r.year DESC, r.month DESC, r.day DESC;
      "
    end

    def self.instance_report_full
      "
      SELECT DISTINCT ON (x.code)
        x.code,
        x.frontend_url,
        x.public_url,
        LEFT(x.name, 75) as name,
        r.year,
        r.month,
        r.day,
        r.data->>'resource' AS resources,
        r.data->>'archival_object' AS archival_objects,
        r.data->>'top_container' AS containers,
        r.data->>'accession' AS accessions,
        r.data->>'digital_object' AS digital_objects,
        r.data->>'user' AS users,
        (
          (r.data->>'resource')::int +
          (r.data->>'archival_object')::int +
          (r.data->>'top_container')::int +
          (r.data->>'accession')::int +
          (r.data->>'digital_object')::int +
          (r.data->>'user')::int
        ) / 6 as score,
        r.data->>'user_last_mtime' AS last_login
      FROM reports r
      JOIN instances x on r.reportable_id = x.id
      AND r.reportable_type = 'Instance'
      ORDER BY x.code, r.year DESC, r.month DESC, r.day DESC;
      "
    end

    def self.repository_report_basic
      "
      SELECT DISTINCT ON (name)
        x.code as name,
        r.data->>'name' AS repo_name,
        i.code as site_code,
        LEFT(i.name, 75) as site_name,
        r.year,
        r.month,
        r.day,
        r.data->>'resource' AS resources
      FROM reports r
      JOIN repositories x on r.reportable_id = x.id
      JOIN instances i ON x.instance_id = i.id
      AND r.reportable_type = 'Repository'
      ORDER BY name, r.year DESC, r.month DESC, r.day DESC;
      "
    end

    def self.repository_report_summary(instance)
      code = ActiveRecord::Base.connection.quote(instance.code)
      "
      SELECT DISTINCT ON (name)
        x.code as name,
        r.data->>'name' AS repo_name,
        i.code as site_code,
        LEFT(i.name, 75) as site_name,
        r.year,
        r.month,
        r.day,
        r.data->>'resource' AS resources,
        r.data->>'archival_object' AS archival_objects,
        r.data->>'top_container' AS containers,
        r.data->>'accession' AS accessions,
        r.data->>'digital_object' AS digital_objects
      FROM reports r
      JOIN repositories x on r.reportable_id = x.id
      JOIN instances i ON x.instance_id = i.id
      AND r.reportable_type = 'Repository'
      WHERE i.code = #{code}
      ORDER BY name, r.year DESC, r.month DESC, r.day DESC;
      "
    end
  end
end
