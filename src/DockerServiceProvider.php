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

    $this->publishes([__DIR__ . '/../devops' => \base_path('devops')], 'laravel-docker');
  }

  /**
   * {@inheritDoc}
   */
  public function register()
  {
    //
  }
}