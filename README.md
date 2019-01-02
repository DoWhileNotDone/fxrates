# README

## Approach

For this exercise, I broke the task down into four parts:

 1. Implement a solution that I was happy enough with using PHP and the symfony framework
 2. Learn the rudiments of the ruby language (via codecademy.com)
 3. Learn the basics of rails (also codecademy) so I could use that to get the main aspects (routes/models) working for my project
 4. Re-implement my solution in ruby/rails so it worked to roughly the same extent as the php project

This was achieved, though the ruby code demonstrates that I still have a lot to learn...

## The Solution

### Development Environment

I initially implemented the solution using PHP 7.1.2 and the Symfony 4 framework.

__Note:__ This code is available on request.

I then implemented the solution using Ruby 2.5.3, and Rails 5.2.1.

### Routes

For testing and demonstration, the site uses a simple MVC with two routes defined:
 - get '/fromsource/:source/:type', to: 'exchange_rate#fromsource'
 - get '/showrate/:date/:fromccy/:toccy', to: 'exchange_rate#showrate'

__FromSource__

The fromsource takes the name and type of feed to call - these are then compared against known feed types stored in the table - e.g. ECB/daily.

The matching record contains the URI to fetch the data from, the type of fetch to make (http), and the parser which will extract and persist the data into the currency records.

It also sets the EUR base rate for the date, so calculations can use this.

__ShowRate__

This takes the date, from currency code, and to currency code, and calculates the cross rate for these.

### Database

It uses a MYSQL 5.7 database as the backend - the scripts are available in the db folder for the schema and data. Rails/Rake may be able to use these to build other database types.

## The Limitations

 * The structure of the code is pretty shoddy, with most of it rammed into the two app helpers.
Ideally, this would be split into meaningful namespaces and modules.

 * There isn't any logging, validation, exception handling, or unit tests to speak of.

 * There isn't much css/html/front-end implementation - as this was for a library, this was kept to the minimum

 * The date expects to be in yyyy-mm-dd format, e.g. 2018-11-30. The iso code as upper case e.g. EUR

 * I used a linter, but I haven't followed any coding standards for ruby/rails, and for comments in PHP I would normally
use DocBlock (http://docs.phpdoc.org/guides/docblocks.html). Not sure what the equivalent is.s

 * I haven't done much around security - as there is no user input or authentication requirements, this was less of a priority.

 * The requirements mention being production ready - this project hasn't been configured for production.

 * The wireframe shows a form that allows amount to be entered. I haven't implemented this, but went for the text requirements of the ExchangeRate.at(Date, From, To).

 * Hopefully I haven't included too many unnecessary cache or third party source files in the zip.
