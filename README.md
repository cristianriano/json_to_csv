# JSON to CSV

The following app offers an endpoint to convert an array of JSON objects into CSV.

Considerations:
- The root object MUST be an array
- Every element of the array MUST be a JSON object (hash)
- For every object there would be 2 CSV lines. First the keys and then the values
- Every object is delimited by an empty line in the CSV

## Installation

1. Install the `ruby` version specified in the `.rbenv` file
2. Run `bundle install` to install all gems
3. To start the server in `production` run `bin/app server`. Server will run in port `8080`

## Development

1. Run all tests with `rspec`
2. To check code quality run `bundle exec rubocop`
3. To start the console run `bin/app console`
4. To boot the server in dev mode run `bin/app server_dev`. Server will run in port `3000`
