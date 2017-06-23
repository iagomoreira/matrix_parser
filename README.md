## Matrix parser

# Installing
Simply run bundle install to install the dependencies

```shell
bundle install
```

Set environment variables with the respective values for the routes source URI and passphrase

```
ROUTES_URI
ROUTES_PASSPHRASE
```

# Usage
To hack the matrix and send the report, all you need to do is use the DataReporter class
```ruby
DataReporter.call
```

# Running the specs
As I used RSpec to test the code all you have to do is run on you terminal:
```shell
rspec
```
