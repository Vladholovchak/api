# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'jsonapi-serializer'
gem 'octokit'
gem 'bcrypt'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'jsom-pagination'
gem 'jsonapi_errors_handler'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
