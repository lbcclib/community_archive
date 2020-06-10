# community_archive
LBCC's institutional repository

## Installation instructions

    git clone https://github.com/lbcclib/community_archive
    cd community_archive

To make life easier, go to app/models/user.rb.  Find the symbol `:cas_authenticatable,`, and replace that with `:database_authenticatable, :registerable,` 

You should also edit config/solr.yml to point to the solr container.

    docker-compose up -d
    docker exec -it community_archive_app_1 /bin/bash
    rake db:migrate

To make life easier, you might also want to:

    docker exec -it psql -U commarch -W commarch
    UPDATE users SET admin=true;

## Deploy
cap (beta|production) deploy 

## Rollback
cap (beta|production) rollback
