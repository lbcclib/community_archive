# community_archive
LBCC's institutional repository

## Installation instructions

    git clone https://github.com/lbcclib/community_archive
    cd community_archive
    bundle install

Then edit `config/database.yml` to point to your postgres server and database

    rails db:migrate
    rake hydra:server

## Deploy
cap (beta|production) deploy 

## Rollback
cap (beta|production) rollback
