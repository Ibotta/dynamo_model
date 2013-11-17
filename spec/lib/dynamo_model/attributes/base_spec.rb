require 'spec_helper'

describe DynamoModel::Attributes::Base do

  let(:att) { DynamoModel::Attributes::Base.new(:key_name) }

  it :initialize do
    att = DynamoModel::Attributes::Base.new(:test, options: 'value')
    expect(att.name).to eq(:test)
    expect(att.opts).to eq({options: 'value'})

    expect(DynamoModel::Attributes::Base::DYNAMO_TYPE).to eq('S')
  end

  it :to_dynamo_value do
    expect(att.to_dynamo_value('test')).to eq('test')
    expect(att.to_dynamo_value(:test2)).to eq('test2')

    mock = double("attr")
    mock.should_receive(:to_s).and_return('mock')
    expect(att.to_dynamo_value(mock)).to eq('mock')
  end

  it :from_dynamo_value do
    expect(att.from_dynamo_value('test')).to eq('test')
    expect(att.from_dynamo_value(:test2)).to eq('test2')

    #not absolutely necessary in practice but tests change to to_s
    mock = double("attr")
    mock.should_receive(:to_s).and_return('mock')
    expect(att.to_dynamo_value(mock)).to eq('mock')
  end

  it :to_dynamo_value_hash do
    att.should_receive(:to_dynamo_value).with('test').and_return('test_2')
    #@todo should actually delegate to adapter
    expect(att.to_dynamo_value_hash('test')).to eq({s: 'test_2'})
  end

  it :to_dynamo_definition_hash do
    att = DynamoModel::Attributes::Base.new(:test, options: 'value')
    #@todo should actually delegate to adapter
    expect(att.to_dynamo_definition_hash).to eq({s: 'test'})
  end

  describe :from_dynamo_value_hash do
    it "returns a value" do
      #@todo is adapter specific, so should delegate
      att.should_receive(:from_dynamo_value).with('test').and_return('test_2')
      expect(att.from_dynamo_value_hash({s: 'test'})).to eq('test_2')
    end
    it "raises exception" do
      #@todo is adapter specific, so should delegate
      att.should_receive(:from_dynamo_value).never
      expect { att.from_dynamo_value_hash({n: 'test'}) }.to raise_error
    end
  end

end
