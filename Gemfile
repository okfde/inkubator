source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
  gem 'thin'
end

group :development do
  gem 'pg'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem "binding_of_caller"
  gem 'pry'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'spring'
  gem "factory_girl_rails"
  gem 'sqlite3'
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  # gem "email_spec"
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
