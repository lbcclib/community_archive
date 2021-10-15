FROM ghcr.io/samvera/hyrax/hyrax-base:3.1.0
ARG APP_PATH=.
ARG BUNDLE_WITHOUT="development test"
COPY --chown=1001:101 $APP_PATH /app/samvera/hyrax-webapp
RUN bundle install --jobs "$(nproc)"
RUN RAILS_ENV=production SECRET_KEY_BASE=`bin/rake secret` DB_ADAPTER=nulldb DATABASE_URL='postgresql://fake' bundle exec rake assets:precompile
