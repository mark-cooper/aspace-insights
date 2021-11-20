# ASpace Insights

Collects data and generates reports from ArchivesSpace instances.

```bash
bundle install --binstubs
./bootstrap.sh

# dev
./bin/shotgun config.ru

# test
./bin/rspec

# production
RACK_ENV=production TOKEN=$TOKEN ./bin/rackup
```
