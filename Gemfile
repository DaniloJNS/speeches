# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

gem 'bcrypt'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'jwt'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'redis'
gem 'securerandom'
gem 'sidekiq'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop-rails', require: false
  gem 'spring'
end

group :test do
  gem 'json_matchers'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
