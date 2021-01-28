#! /bin/sh

echo 'Waiting for MySQL...'

until nc -z -v -w30 $DB_HOST $DB_PORT; do
 sleep 1
done

echo "MySQL is up and running!"

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate

rm /app/tmp/pids/server.pid

bundle exec puma -C config/puma.rb
