#!/bin/sh

set -x

echo 'Waiting for MySQL...'

until nc -z -v -w30 $DB_HOST $DB_PORT; do
 sleep 1
done

echo "MySQL is up and running!"

# wait for elasticsearch
until nc -vz $ELASTICSEARCH_HOST 9200; do
  echo "Elasticsearch is not ready, sleeping..."
  sleep 1
done

echo "Elasticsearch is ready, starting Rails."

rm /rails/tmp/pids/server.pid

# setup database and start puma
RAILS_ENV=development bundle exec rake db:create
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec rake db:seed
RAILS_ENV=development bundle exec rails s -p 3000 -b '0.0.0.0'