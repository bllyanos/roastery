#!/bin/sh

# create db
mix ecto.create

# run migrations
mix ecto.migrate

# run secret gen
mix phx.gen.secret

# Run main process
exec "$@"