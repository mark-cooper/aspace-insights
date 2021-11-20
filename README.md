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
