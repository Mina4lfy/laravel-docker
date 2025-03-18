#!/bin/sh

set -eux

# Install composer & npm packages.
function install_dependencies()
{
  composer install
  npm install && npm run build
}

# Remove existing files that may belong to old builds.
function remove_old_files()
{
  rm -f bootstrap/cache/*.php \
    app/secrets/oauth/*.key \
    storage/framework/*/*.php \
    storage/debugbar/*.json \
    storage/logs/*.log
}

# Initialize Laravel project.
function laravel_init()
{
  php artisan storage:link --force
  php artisan key:generate
  php artisan migrate:fresh --seed
}

# Here starts everything.
function main()
{
  set -eux

  reset

  install_dependencies
  remove_old_files
  laravel_init
}
main "$@"; exit
