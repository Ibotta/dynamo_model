# DynamoModel

DynamoModel is an attempt at building a more flexible ActiveRecord-like interface
for DynamoDB.  It utilizes ActiveModel and ActiveSupport to accomplish most of this.

This is still in its infancy and I would absolutely love any assistance. Contact me (@onyxraven)
here on github.

## Links

* [Documentation](http://rdoc.info/github/Ibotta/dynamo_model/master/frames)
* [DynamoDB API](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/operationlist.html)
* [aws-sdk DynamoDB Client](http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/DynamoDB/Client/V20120810.html)
* [![Code Climate](https://codeclimate.com/github/Ibotta/dynamo_model.png)](https://codeclimate.com/github/Ibotta/dynamo_model)

> TODO travis.ci

## Goals

### High Level
 * Provide an ActiveRecord like interface for DynamoDB records
 * Provide a query builder for more advanced queries
 * Provide a method of generating table definitions like migrations/schema.rb
 * Provide an interface that hides underlying dynamo DB client adapter for the most part

### Technical
 * Support simple HashKeys as well as RangeKeys
 * Support secondary indexes in > V20120810
 * Support paginated (incomplete) result sets
 * Support V20120810 protocol in first release
 * Support V20111205 for compatibility through adapter pattern
 * Support aws-sdk-core (> 2.0 of the ruby sdk) through adapter pattern

## Current Status

This is a very basic Proof of Concept as of now. Will (hopefully) quickly be functionally
complete.

### Known Issues

* Currently does not implement an adapter! Yes, this is coming next.

### ToDos
This is a list of high-level todo items.  More specific todos are in the code (and docs).

I know there's a lot to do still, so I will try to keep this list up to date.

* Pick a more clever name.  Was thinking about something like Maxwell.
* Begin adapter for the aws-sdk 1.x V20111205 protocol
* Begin high level configuration
* Set up for clean multithread support
* Figure out best way for automated testing against a mock API
* Figure out how to support something like FactoryGirl against this api for developers using it.
* Rails project demo
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

## Motivation

The new protocol has been out for a while, and Amazon has been promoting any new app to
use it instead of the 2011 protocol. It supports Range Keys, multiple indexes, and implements
a totally different api structure when it comes to table definitions, etc.

However, the aws-sdk HashModel, ItemCollection, etc are not even capable of supporting range_keys, nevermind other new features.  It seems that HashModel, etc are intended as drop-in replacements
for the Aws::Record::Model class, replacing SimpleDB with DynamoDB.  Even the Aws::DynamoDB#* will only instantiate the 2011 client.

Amazon's ruby SDK developers have discontinued new work on 1.x in preparation of the 2.x aws-sdk-core, which lacks any model classes altogether at this point.

[Dynamoid](https://github.com/Veraticus/Dynamoid), which is a great start, builds on top of HashModel.  So does [Minidynamo](https://github.com/Vlipco/minidynamo).  This gem is inspired by these projects, but strives to be a more generic and flexible adapter.

## Contributing

Please help!  This is my first time working on a gem of this scope and I think it
could be really useful!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
