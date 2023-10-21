#!/bin/bash

sudo apt update > /dev/null

# Install postgresql
sudo apt install postgresql postgresql-contrib -y > /dev/null

# Check if postgresql is running
sudo systemctl status postgresql

USER_PASSWD="postgres"


# Change postgres user password
sudo -u  postgres  psql -c "ALTER USER postgres WITH PASSWORD '$USER_PASSWD';"

if [$? -eq 0]; then echo "postgres user password succesfully updated." ;fi


# Crear una base de datos llamada "exampledb"
sudo -u postgres createdb exampledb
if [$? -eq 0]; then echo "Database 'exampledb' successfully created." ;fi




# Get postgres database version
PG_VERSION=$(ls /etc/postgresql)

# IF version valid set PG_VERSION variable
if [ -z "$PG_VERSION" ]; then
  echo "no PostgreSQL found."
  exit 1
fi

# Postgres config file path
CONF_FILE="/etc/postgresql/$PG_VERSION/main/postgresql.conf"

# If config file valid
if [ -f "$CONF_FILE" ]; then
  
  sudo sed -i 's/#listen_addresses = '\''localhost'\''/listen_addresses = '\''*'\''/' "$CONF_FILE"
  echo " postgresql.conf file updated."
else
  echo "No such a file : $CONF_FILE"
fi

# Edit postgres conf to allow connection for remotes servers
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/$PG_VERSION/main/pg_hba.conf

# Restart postgres service
sudo systemctl restart postgresql

sudo systemctl status postgresql


