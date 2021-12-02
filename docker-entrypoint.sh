#!/bin/bash

if [ "$DB_MIGRATE" = true ]; then
  ./bin/rake db:create
  ./bin/rake db:migrate
fi

exec "$@"
