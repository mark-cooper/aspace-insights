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

Import report data:

```bash
./server.sh
curl -X POST -d @spec/fixtures/report.json "http://localhost:3000/instances?token=01609d9cc98201a9c859dece3035e19d"
```
