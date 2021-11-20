# ASpace Insights

Collects data and generates reports from ArchivesSpace instances.

```bash
bundle binstubs --all
./bootstrap.sh

# dev server
./bin/shotgun config.ru -p 3000

# dev cli
./bin/pry -I . -r main.rb

# test
./bin/rspec

# production
RACK_ENV=production TOKEN=$TOKEN ./bin/puma -p 3000
```
