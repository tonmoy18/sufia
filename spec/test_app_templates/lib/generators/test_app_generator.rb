require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "./spec/test_app_templates"

  def install_engine
    generate 'sufia:install', '-f'
  end

  def browse_everything_config
    generate "browse_everything:config"
  end

  def banner
    say_status("info", "TEST ENVIRONMENT OVERRIDES", :blue)
  end

  def add_analytics_config
    append_file 'config/analytics.yml' do
      "\n" +
        "analytics:\n" +
        "  app_name: My App Name\n" +
        "  app_version: 0.0.1\n" +
        "  privkey_path: /tmp/privkey.p12\n" +
        "  privkey_secret: s00pers3kr1t\n" +
        "  client_email: oauth@example.org\n"
    end
  end

  def enable_analytics
    gsub_file "config/initializers/sufia.rb",
              "config.analytics = false", "config.analytics = true"
  end

  def enable_arkivo_api
    generate 'sufia:models:arkivo_api'
  end

  def relax_routing_constraint
    gsub_file 'config/initializers/arkivo_constraint.rb', 'false', 'true'
  end
end
