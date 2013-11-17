# DynamoModel

DynamoModel is an attempt at building a more flexible ActiveRecord-like interface
for DynamoDB.  It utilizes ActiveModel and ActiveSupport to accomplish most of this.

This is still in its infancy and I would absolutely love any assistance. Contact me (@onyxraven)
here on github.

## Links

* [Documentation](http://rdoc.info/github/Ibotta/dynamo_model/master/frames)
* [DynamoDB API](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/operationlist.html)
* [aws-sdk DynamoDB Client](http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/DynamoDB/Client/V20120810.html)

## Goals

### High Level
 * Provide an ActiveRecord like interface for DynamoDB records
 * Provide a query builder for more advanced queries
 * Provide a method of generating table definitions like migrations/schema.rb

### Technical
 * Support simple HashKeys as well as RangeKeys
 * Support secondary indexes in > V20120810
 * Support paginated (incomplete) result sets
 * Support V20120810 protocol in first release
 * Support V20111205 for compatibility through adapter pattern
 * Support aws-sdk-core (> 2.0 of the ruby sdk) through adapter pattern

## Current Status

This is a very basic Proof of Concept as of now. Not a lot of tests, if any.

### Known Issues

### ToDos
I know there's a lot to do still, so I will try to keep this list up to date.

* Pick a more clever name.  Was thinking about something like Maxwell.
* Begin writing tests for skeleton PoC
* ... lots more ...

## Installation

Add this line to your application's Gemfile:

    gem 'dynamo_model', git: "https://github.com/Ibotta/dynamo_model"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamo_model

## Usage

See the [Documentation](http://rdoc.info/github/Ibotta/dynamo_model/master/frames)

```ruby

class DDB < DynamoModel::Base

  definition do |d|
    d.table_name 'test'
    d.hash_key :id
    d.timestamps
  end

end



```

## Contributing

Please help!  This is my first time working on a gem of this scope and I think it
could be really useful!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
