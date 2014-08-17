[![Build Status](https://travis-ci.org/ryanfreng/filmwin.svg?branch=master)](https://travis-ci.org/ryanfreng/filmwin)

# Filmwin - The Awards Show App

Award show submission and judging doesn't have to suck, or be expensive. This app provides a place for you to host submission and judging of an award show. You can provide a youtube or vimeo url or upload files to Amazon S3.

Config
------------

Create an aws account setup and accepting xss from your host.

Create paypal testing accounts (personal/business) so you can test before you push live.

Make sure to set the following environment variables in a .env file for foreman:

````
S3_BUCKET=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
PAYPAL_ADDRESS=
ENVIRONMENT=
````

Running
------

You'll need to use foreman to run tests and your webserver in order to pick up the .env variables from above:

```
foreman run guard

foreman run rails s
```
