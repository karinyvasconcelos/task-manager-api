# TaskManagerApi::Application.configure do
#   # Settings specified here will take precedence over those in config/application.rb

#   # In the development environment your application's code is reloaded on
#   # every request. This slows down response time but is perfect for development
#   # since you don't have to restart the web server when you make code changes.
#   config.cache_classes = false

#   # Log error messages when you accidentally call methods on nil.
#   config.whiny_nils = true

#   # Show full error reports and disable caching
#   config.consider_all_requests_local       = true
#   config.action_controller.perform_caching = false

#   # Don't care if the mailer can't send
#   config.action_mailer.raise_delivery_errors = false

#   # Print deprecation notices to the Rails logger
#   config.active_support.deprecation = :log

#   # Only use best-standards-support built into browsers
#   config.action_dispatch.best_standards_support = :builtin

#   # Raise exception on mass assignment protection for Active Record models
#   config.active_record.mass_assignment_sanitizer = :strict

#   # Log the query plan for queries taking more than this (works
#   # with SQLite, MySQL, and PostgreSQL)
#   config.active_record.auto_explain_threshold_in_seconds = 0.5

#   # Do not compress assets
#   config.assets.compress = false

#   # Expands the lines which load the assets
#   config.assets.debug = true
# end

TaskManagerApi::Application.configure do
# Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
