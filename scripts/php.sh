#!/bin/bash

container_name="phpmyadmin_elixir"
db_host="elixir_db" # Name of your MySQL container
port="8080"         # phpMyAdmin will be accessible at localhost:8080

docker run --name $container_name \
  -p $port:80 \
  -e PMA_HOST=$db_host \
  -e PMA_PORT=3306 \
  -d \
  --restart unless-stopped \
  --link elixir_db:db \
  phpmyadmin:latest

echo "phpMyAdmin is starting..."
echo "Access it at: http://localhost:$port"
echo ""
echo "Login credentials:"
echo "Username: victor (or root)"
echo "Password: von (or doom for root)"
