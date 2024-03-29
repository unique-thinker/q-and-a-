# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '7.0.3.1'

# Use postgresql as the database for Active Record
gem 'pg', '1.4.3'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '5.6.4'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# OAuth JSON Web Token
gem 'jwt', '2.4.1'
# The bcrypt Ruby gem provides a simple wrapper for safely handling passwords.
gem 'bcrypt', '3.1.18'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'pry', '0.14.1'
  # help to kill N+1 queries and unused eager loading.
  gem 'bullet', '7.0.2'
  # RuboCop is a Ruby code style checking and code formatting tool
  gem 'rubocop', '1.34.1', require: false
  # Testing framework
  gem 'rspec-rails', '6.0.0.rc1'
  # Factory_bot is a fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails', '6.2'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end

group :test do
  # Generate fake data
  gem 'faker', '2.22'
  gem 'shoulda-matchers', '5.1'
  # Clean your ActiveRecord databases with Database Cleaner.
  gem 'database_cleaner-active_record'
end
