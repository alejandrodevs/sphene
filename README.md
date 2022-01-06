# Sphene

This gem aims to provide a lightweight and simple implementation of typed attributes. it implements a lazy attribute casting.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sphene'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sphene

## Usage

Just include `Sphene::Attributes` in your class and define your
attributes:

```ruby
class User
  include Sphene::Attributes

  attribute :name, Types::String
  attribute :email, Types::String
  attribute :active, Types::Boolean, default: true
end
```

Check the types available here: [Types](https://github.com/alejandrodevs/sphene/blob/master/lib/sphene/types.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alejandrodevs/sphene. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/alejandrodevs/sphene/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sphene project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alejandrodevs/sphene/blob/master/CODE_OF_CONDUCT.md).
