# lull
rest-client helper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lull'
```

And then execute:

    $ bundle install lull

Or just:

    $ gem install lull

## Usage

```ruby
require 'lull'
```

## Make REST call
---------------------------

###After require 'lull'

Simple calls are easy, "Get" is the default and the only required argument is url.

```ruby
# Make call
url = 'https://something.you.want'
response = Lull.new(url: url).rest_try
puts response.code
puts response.body
puts response.headers
```

In the example above, three attempts will be made. You can set the number of retries.
A custom timeout can also be specified (the default is 30 seconds).


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install` or follow the instructions at the top of the readme.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kodywilson/lull. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
