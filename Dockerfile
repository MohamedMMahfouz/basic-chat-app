FROM ruby:2.5.1 

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs git-core
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app
WORKDIR /app 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler && bundle install --jobs 20 --retry 5
ADD . /app


# CMD ./startup.sh
