FROM ruby:2.5.5 as builder

# Necessary for bundler to properly install some gems
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install FITS
RUN apt-get update && apt-get install -y default-jre libreoffice ghostscript nodejs
RUN mkdir -p /opt/fits && \
    curl -fSL -o /opt/fits/fits-latest.zip https://projects.iq.harvard.edu/files/fits/files/fits-1.3.0.zip && \
    cd /opt/fits && unzip fits-latest.zip && chmod +X /opt/fits/fits.sh

RUN mkdir -p /var/www/hyrax
COPY . /var/www/hyrax
RUN gem install bundler
WORKDIR /var/www/hyrax
RUN bundle install

COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
