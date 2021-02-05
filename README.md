# community_archive
LBCC's institutional repository

## Installation instructions

    git clone https://github.com/lbcclib/community_archive
    cd community_archive
    docker-compose up -d
    docker-compose exec app bin/rake db:migrate
    docker-compose exec app bundle exec rails hyrax:default_collection_types:create
    docker-compose exec app bin/rails hyrax:default_admin_set:create

To make life easier, after you create an account, you'll also want to:

    docker-compose exec db psql -U commarch -W commarch -c "UPDATE users SET admin=true"

## Deploy
    cap (beta|production) deploy
    cap (beta|production) solr:update_config # only if you made some changes to the solr configurations

## Rollback
    cap (beta|production) rollback
