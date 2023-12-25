source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '7.1.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '>= 4.9'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'sass-rails', '>= 6'
gem 'slim-rails', '~> 3.6.3'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 3.2'
  gem 'letter_opener_web', '~> 2.0'
  gem 'pry-byebug', '~> 3.10'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop', '~> 1.57.2', require: false
  gem 'rubocop-capybara', '~> 2.19', require: false
  gem 'rubocop-performance', '~> 1.19', '>= 1.19.1', require: false
  gem 'rubocop-rails', '~> 2.22.0', require: false
  gem 'rubocop-rspec', '~> 2.25.0', require: false
end

group :development do
  gem 'erb-formatter'
  gem 'html2slim-ruby3', '~> 0.2.1'
  gem 'listen', '~> 3.3'
  gem 'rufo'
  gem 'solargraph'
  gem 'spring', '3.0.0'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
