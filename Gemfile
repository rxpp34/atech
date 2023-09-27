source 'https://rubygems.org'

gem 'rails', '~> 4.2.8'
gem 'pg'
gem 'haml'
gem 'devise'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin.git', :ref => 'e27ccba8a7ea'
gem 'rails-i18n'
gem 'remote_table'
gem 'jquery-rails'
gem 'passenger', '~> 5.0.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'bower'
gem 'activeadmin_select2', git: 'https://github.com/bartocc/active_admin_select2.git'
gem 'carrierwave'
gem 'cloudinary'
gem 'prawn'
gem 'postgres_ext', git: 'https://github.com/shaneog/postgres_ext.git', ref: '88d46f6c14'
gem 'dotenv-rails'

# Test gems
###########

group :development do
  gem "capistrano", "~> 3.11", require: false
  gem 'capistrano-bundler', '~> 1.3'
  gem 'capistrano-rbenv', '~> 2.1'
  gem "capistrano-rails", "~> 1.4", require: false
end

group :test, :development do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'awesome_print'
  gem 'spring'
end

# Production gems
#################

group :production do
  # gem 'rails_12factor'
end
