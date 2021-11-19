# ASpace Insights

Collects data and generates reports from ArchivesSpace instances.

```bash
bundle install --binstubs

# dev
bundle exec shotgun config.ru

# test
bundle exec rspec

# production
RACK_ENV=production TOKEN=$TOKEN bundle exec rackup
```
