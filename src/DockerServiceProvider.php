<?php

namespace Mina4lfy\LaravelDocker;

use Illuminate\Support\ServiceProvider;

class DockerServiceProvider extends ServiceProvider
{
  /**
   * Boot the LaravelDocker service
   *
   * @return void
   */
  public function boot()
  {
    if (!$this->app->runningInConsole()) {
      return;
    }

    $this->publishes([
      __DIR__ . '/../devops'              => \base_path('devops'),
      __DIR__ . '/../docker-compose.yml'  => \base_path('docker-compose.yml'),
      __DIR__ . '/../.dockerignore'       => \base_path('.dockerignore'),
    ], 'laravel-docker');
  }

  /**
   * {@inheritDoc}
   */
  public function register()
  {
    //
  }
}