# Lunch and Learn 
### Built With

 [![Rails][Rails.org]][Rails-url]

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

*Postman Testing and Results*
- run `rails s` in the terminal
- Open Postman and run the following requests with necessary params (or body):
```
GET localhost:3000/api/v1/recipes
```
```
GET localhost:3000/api/v1/learning_resources
```
```
POST localhost:3000/api/v1/users
```
```
POST localhost:3000/api/v1/favorites
```
```
GET localhost:3000/api/v1/favorites
```
*Project Link*

[Lunch and Learn](https://backend.turing.edu/module3/projects/lunch_and_learn/)

*Learning Goals*
1. Expose an API that aggregates data from multiple external APIs
2. Expose an API that requires an authentication token
3. Expose an API for CRUD functionality
4. Determine completion criteria based on the needs of other developers
5. Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

*Github Repository*
- [Lunch and Learn](https://github.com/thayes87/lunch_and_learn)


[Rails.org]: https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org

