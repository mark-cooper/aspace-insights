# ASpace Insights

Collects data and generates reports from ArchivesSpace instances.

```bash
bundle install --binstubs
./bootstrap.sh

# dev
./bin/shotgun config.ru -p 3000

# test
./bin/rspec

# production
RACK_ENV=production TOKEN=$TOKEN ./bin/puma -p 3000
```
