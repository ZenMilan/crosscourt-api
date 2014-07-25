# Crosscourt API

[![Build Status](https://travis-ci.org/pruett/crosscourt-api.svg?branch=develop)](https://travis-ci.org/pruett/crosscourt-api)

## Getting Started

* Install Ruby version 2.1.2
* Install bundler if you need to
  * `gem install bundler`
* Bootstrap project
  * `rake bootstrap`

## Run tests

* `rake`

## Local Nginx Setup

```bash
server {
  listen       80;
  server_name  api.crosscourt.io;

  access_log /usr/local/etc/nginx/logs/nginx_access.log;
  error_log /usr/local/etc/nginx/logs/nginx_error.log warn;

  location / {
    rewrite ^/(.*) /api/$1 break;
    proxy_set_header Host $http_host;
    proxy_pass http://localhost:4567;
  }
}
```
