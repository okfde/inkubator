source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development do
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'pry'
end

group :development, :production do
  gem 'pg'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'spring'
  gem "factory_girl_rails"
  gem 'database_cleaner'
  gem 'sqlite3'
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  gem 'faker'
  gem 'capybara'
  # gem "email_spec"
end

group :test do
  gem 'shoulda-matchers', require: false
end
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation', '~> 4.0.4'
end

gem 'cancan'
gem 'jquery-rails'
gem 'devise'
gem 'haml-rails'
gem 'thin'
gem 'rinku', '~> 1.7', :require => 'rails_rinku'
gem 'rollbar'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
