source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "haml-rails", "~> 2.1"
gem "pg", "~> 1.4"
gem "will_paginate", "~> 3.3.1"
gem "bootstrap-will_paginate", "~> 1.0.0"
gem "bootstrap", "~> 5.3"
gem "sassc-rails"
gem "devise"
gem "devise-i18n"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
end

gem "rspec-rails", "~> 8.0", groups: [ :development, :test ]
