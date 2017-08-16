# community_archive
LBCC's institutional repository

To install:

    $ rails new hyrax --database=postgresql

Add to Gemfile:

    gem 'therubyracer'
    gem 'hyrax', git: 'https://github.com/projecthydra-labs/hyrax.git'

    $ bundle install
    $ rails generate hyrax:install -f
    $ rails generate hyrax:work Syllabus
    $ rails generate hyrax:work NewspaperIssue

pull this stuff in using git

    $ rake db:migrate
    $ rake hyrax:workflow:load
