# Crosscourt API

[![Build Status](https://travis-ci.org/pruett/crosscourt-api.svg?branch=develop)](https://travis-ci.org/pruett/crosscourt-api)

## Set Up

* Install Ruby version 2.1.2
* Wipe / Rebuild DB
  * `RAKE_ENV=test rake db:drop db:create db:migrate db:test:prepare`
* run `bundle`
* run `bundle exec rspec .` ensuring all tests are passing
