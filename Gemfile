source 'https://rubygems.org'

ruby '2.6.6'
gem 'rails', '6.1.2'
gem 'pg', '~> 1.1'
gem 'rails-controller-testing'
gem "tailwindcss-rails", "~> 2.0"

# for Heroku deployment 
group :development, :test do
  gem 'byebug'
  gem 'database_cleaner', '1.4.1'
  gem 'capybara', '2.8'
  gem 'launchy'
  gem 'rspec-rails', '5.0.1'
  gem 'ZenTest', '4.11.2'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
end
group :production do
end

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '>= 2.7.1'
gem 'jquery-rails'