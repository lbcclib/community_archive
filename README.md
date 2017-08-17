# community_archive
LBCC's institutional repository

## Installation instructions

    $ rails _5.1.2_ new hyrax --database=postgresql

Add these two lines to the Gemfile:

    gem 'therubyracer'
    gem 'hyrax', git: 'https://github.com/samvera/hyrax.git'

Then run these commands:

    $ bundle install
    $ rails generate hyrax:install -f
    $ rake db:migrate
    $ rails generate hyrax:work Syllabus
    $ rails generate hyrax:work NewspaperIssue
    $ git remote add origin https://github.com/sandbergja/community_archive
    $ git pull origin master
    $ git reset --hard origin/master
    $ bundle install
    $ rake db:migrate
    $ rake hyrax:workflow:load

If you'd like to start it, run `rake hydra:server`
