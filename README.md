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
