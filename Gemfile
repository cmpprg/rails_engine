source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'json'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'simplecov', require: false, group: :test
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'active_model_serializers', '~> 0.10.0'
end

group :test do

  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
