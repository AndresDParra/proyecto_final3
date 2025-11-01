#!/bin/bash

container_name="elixir_db"
e_root_pw_sql="doom"
e_db_name="taxis_db"
port="3306"
local_vol="/Users/andresdavidparraparra/docker_volumes/elixir_db_v3" # ← Changed to v3
e_user="victor"
e_user_passw="von"
container_vol="/var/lib/mysql"

# Create the directory if it doesn't exist
mkdir -p $local_vol

docker run --name $container_name \
  -p $port:3306 \
  -v $local_vol:$container_vol \
  -e MYSQL_ROOT_PASSWORD=$e_root_pw_sql \
  -e MYSQL_USER=$e_user \
  -e MYSQL_PASSWORD=$e_user_passw \
  -e MYSQL_DATABASE=$e_db_name \
  -d \
  --restart unless-stopped \
  mysql:8.0 \
  --default-authentication-plugin=mysql_native_password
