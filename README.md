# Crosscourt API

[![Build Status](https://travis-ci.org/pruett/crosscourt-api.svg?branch=develop)](https://travis-ci.org/pruett/crosscourt-api)

## Set Up

* Install Ruby version 2.1.2
* Install bundler if you need to
  * `gem install bundler`
* Run bundle
  * `bundle`
* Wipe / Rebuild DB
  * `RAKE_ENV=test rake db:drop db:create db:migrate db:test:prepare`
* Run Rspec
  * `bundle exec rspec .`
