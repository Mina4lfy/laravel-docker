#!/bin/sh

set -eux

# Copy .env.example to .env if not exists.
[ ! -f .env ] && cp .env.example .env

# Check if "--hard" is present in the arguments
if [ "$#" -eq 0 ]; then

  docker compose down

else

  for arg in "$@"; do

    case "$arg" in
    --volumes)
      docker compose down --volumes
      break
      ;;
    esac

    case "$arg" in
    --hard)
      docker compose down --volumes --remove-orphans --rmi local
      break
      ;;
    esac

    case "$arg" in
    --reinstall)
      docker compose down --volumes --remove-orphans --rmi local
      docker compose up -d
      sleep 10
      docker exec laravel-app ./devops/install.sh
      break
      ;;
    esac

  done

fi

docker compose up -d

docker exec -it laravel-app sh || docker logs laravel-app || exit 1
