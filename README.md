# Lunch and Learn 

*versions* 
- Ruby 2.7.4p191
- Rails 5.2.8.1

*gems*
- gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
- gem 'pry'
- gem 'figaro'
- gem 'factory_bot_rails'
- gem 'launchy'
- gem 'orderly'
- gem 'rspec-rails'
- gem 'shoulda-matchers'
- gem 'simplecov'
- gem 'vcr'
- gem 'webmock'
- gem 'faker'
- run `bundle install` in terminal
- run `bundle exec fiagro install` in terminal

*configuration*
- add the following to spec/spec_helper.rb:
```
require 'webmock/rspec'
```
```
require 'simplecov'
SimpleCov.start 'rails'
SimpleCov.add_filter ['config','channels', 'jobs', 'mailers']
```
- add the following to spec/rails_helper.rb
  - in the |config| block:
```
config.include FactoryBot::Syntax::Method
``` 
  - at the bottom of the file (both):
```
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
```
```
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<app_id>') { ENV['edamam_id'] }
  config.filter_sensitive_data('<app_key>') { ENV['edamam_key'] }
  config.filter_sensitive_data('<key>') { ENV['youtube_api_key'] }
  config.filter_sensitive_data('<client_id>') { ENV['unsplash_api_key'] }
  config.filter_sensitive_data('<api_key>') { ENV['places_key'] }
  config.configure_rspec_metadata!
end
```




*Database creation*
- run `rails db:{create,migrate}` in the terminal

*How to run the test suite*
- Run `bundle exec rspec` in the terminal to run the entire test suite

