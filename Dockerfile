FROM ruby:2.5.5 as builder

# Necessary for bundler to properly install some gems
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN mkdir -p /var/www/hyrax
COPY . /var/www/hyrax
RUN gem install bundler
WORKDIR /var/www/hyrax
RUN bundle install

COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
