# community_archive
LBCC's institutional repository

## Installing a development instance on your own computer

Be sure the following software is installed on your computer:
* Docker
* Docker compose
* Git

    git clone https://github.com/lbcclib/community_archive
    cd community_archive
    docker-compose up -d
    docker-compose exec app bin/rake db:migrate
    docker-compose exec app bundle exec rails hyrax:default_collection_types:create
    docker-compose exec app bin/rails hyrax:default_admin_set:create

To make life easier, after you create an account, you'll also want to:

    docker-compose exec db psql -U commarch -W commarch -c "UPDATE users SET admin=true"

## Installing a production or staging instance in kubernetes

Be sure the following software is installed on your computer:
* Azure CLI
* Git
* Kubectl
* Helm
* Ruby

Create a new temporary directory on your own computer (not strictly necessary; I just find that it keeps things tidier to do this in its own directory than getting it mixed in with the directory you use for development).  From that directory:

        git clone https://github.com/lbcclib/community_archive
        ruby community_archive/.helm/deploy.rb install [COMMIT HASH] [Name of new environment, e.g. beta]

Note: this will create an application with a completely blank SQL database, which will not work right away.  It's very suitable if you have a pg_dump that you'd like to pg_restore into an empty database with minimal fuss.  However, if you just want a working system and don't care about importing a previous database export, edit helm/values.yml to set `skipHyraxEngineSeed` to true before installing.

## Updating a production or staging instance in kubernetes

Be sure the following software is installed on your computer:
* Azure CLI
* Git
* Kubectl
* Helm
* Ruby

Create a new temporary directory on your own computer (not strictly necessary; I just find that it keeps things tidier to do this in its own directory than getting it mixed in with the directory you use for development).  From that directory:

        git clone https://github.com/lbcclib/community_archive
        ruby community_archive/.helm/deploy.rb install [COMMIT HASH] [Name of environment, e.g. production]

Note that all new commits to the master branch are automatically deployed to the staging server via Github actions, so you never have to push them.
