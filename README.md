# ASpace Insights

Collects data and generates reports from ArchivesSpace instances.

```bash
bundle install
./bootstrap.sh

# dev server
./server.sh

# dev cli
./cli.sh

# test
./bin/rspec

# production
RACK_ENV=production TOKEN=$TOKEN ./bin/puma -p 3000
```

## Docker

```bash
docker-compose build
docker-compuse up
```

## Loading data

Start the server with `./server.sh` (dev) or `docker-compose up` (prod):

```bash
curl -X POST -d @spec/fixtures/report.json "http://localhost:3000/instances?token=01609d9cc98201a9c859dece3035e19d"
curl -X POST -d @spec/fixtures/report1.json "http://localhost:3000/instances?token=01609d9cc98201a9c859dece3035e19d"
```

## Starter queries

```bash
# Basic instances
SELECT DISTINCT ON (x.code)
  x.code,
  LEFT(x.name, 75),
  r.year,
  r.month,
  r.day,
  r.data->>'resource' AS resources,
  r.data->>'user_last_mtime' AS last_login
FROM reports r
JOIN instances x on r.reportable_id = x.id
AND r.reportable_type = 'Instance'
ORDER BY x.code, r.year DESC, r.month DESC, r.day DESC
;

# Basic instances with record by types avg (score)
SELECT DISTINCT ON (x.code)
  x.code,
  LEFT(x.name, 75),
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
ORDER BY x.code, r.year DESC, r.month DESC, r.day DESC
;

# Basic repositories
SELECT DISTINCT ON (name)
  x.code as name,
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
ORDER BY name, r.year DESC, r.month DESC, r.day DESC
;
```
