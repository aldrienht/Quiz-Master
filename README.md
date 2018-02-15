# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Install/Bundling used Gems
* cd app_dir
* bundle install

## Create Database & Seed Default Admin User
* Update app_dir/config/database.yml
* change username & password based on your environment setup for PostgreSQL
* rails db:setup

## Running App Locally
* cd app_dir
* rails server or rails s
* open browser and visit: http://localhost:3000/

## If you encounter some error like below:
- No such file or directory Is the server running locally and accepting connections on Unix domain socket
- A pid file was blocking postgres from starting up. To fix it:
* rm /usr/local/var/postgres/postmaster.pid

## Running RSPEC Tests
* cd app_dir
- To run all tests
  * bundle exec rspec
- To run individual test
  * bundle exec rspec spec/to_be_followed_by_dir_and_spec_file.rb
