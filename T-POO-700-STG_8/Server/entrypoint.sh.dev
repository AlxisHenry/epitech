#!/bin/sh
mix deps.get
mix ecto.drop
mix ecto.create
mix ecto.migrate
mix phx.server
mix phx.swagger.generate