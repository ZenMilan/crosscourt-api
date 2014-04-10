# Crosscourt API

[![Build Status](https://travis-ci.org/pruett/crosscourt-api.svg?branch=develop)](https://travis-ci.org/pruett/crosscourt-api)

### Stack

- [Grape](https://github.com/intridea/grape)
- [ActiveRecord](http://rubygems.org/gems/activerecord)
- [PG](http://www.postgresql.org/docs/)

### Authentication

- [Warden](https://github.com/hassox/warden)

### Testing

- Rspec 3.0.0.beta2

### Dev Notes
While developing individually, I tend to overwrite the database migrations :)

If so, use the following:

`RAKE_ENV=test rake db:drop db:create db:migrate`

Might have to run `rake db:test:prepare` as well?
