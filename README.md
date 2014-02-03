# Crosscourt API

### Stack

- [Grape](https://github.com/intridea/grape)
- [ActiveRecord](http://rubygems.org/gems/activerecord)
- [PG](http://www.postgresql.org/docs/)

### Authentication

- [Warden](https://github.com/hassox/warden)

### Testing

- Rspec 3.0.0.beta1

### Dev Notes
While developing indivdually, I tend to overwrite the database migrations :)

If so, use the following:

`RAKE_ENV=test rake db:drop db:create db:migrate`
