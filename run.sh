#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e


# Ensure the app's dependencies are installed
mix deps.get

# Prepare Dialyzer if the project has Dialyxer set up
if mix help dialyzer >/dev/null 2>&1
then
  echo "\nFound Dialyxer: Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "\nNo Dialyxer config: Skipping setup..."
fi

# Build Angular frontend
echo "\nBuilding Angular project..."
cd frontend && npm install && npm run build
cd ..
cp api/priv/static/index.html api/lib/api_web/templates/page/index.html.eex
sed -i -E "s|src=\"([^\\.]+)\\.js\"|src=\"<%= static_path(@conn, \"/\1\.js\") %>\"|g" api/lib/api_web/templates/page/index.html.eex

# Wait for Postgres to become available.
until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "\nPostgres is available: continuing with database setup..."

# Potentially Set up the database
mix ecto.reset

echo "\nTesting the installation..."
# "Proove" that install was successful by running the tests
mix test

echo "\n Launching Phoenix web server..."
# Start the phoenix web server
mix phx.server