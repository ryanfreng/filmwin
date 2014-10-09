source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=filmwin

gem 'rails', '4.0.8'
gem 'bootstrap-sass', '3.2.0.1' #'2.3.2.0'
gem 'sprockets', '2.11.0'
gem 'pg', '0.15.1'
gem 'bcrypt-ruby', '3.1.2'
#gem 'faker', '1.1.2'
gem 'faker', '1.4.2'
gem 'will_paginate', '3.0.7'
#gem 'bootstrap-will_paginate', '0.0.9'
gem 'will_paginate-bootstrap', '1.0.1'
gem 'aws-sdk', '1.50.0'
gem 'newrelic_rpm', '3.9.1.236'

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem 'guard-rspec', '2.5.0'
  gem 'guard-livereload', require: false
  gem 'sass-rails-source-maps'
  gem 'coffee-rails-source-maps'
  gem 'foreman', '0.74.0'
  gem 'factory_girl_rails', '4.2.0'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'capybara-bootstrap-datepicker', '0.0.7'
  gem 'growl', '1.0.3'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
end

gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '>= 2.1.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '~> 1.0.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'rails_12factor', '0.0.2'
end