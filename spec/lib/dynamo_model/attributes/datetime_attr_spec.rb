require 'spec_helper'

describe DynamoModel::Attributes::DatetimeAttr do

  let(:att) { DynamoModel::Attributes::DatetimeAttr.new(:key_name) }
  let(:dt) { DateTime.parse('2013-11-12 14:15:16') }

  it :to_dynamo_value do
    expect(att.to_dynamo_value(dt)).to eq('2013-11-12T14:15:16+00:00')
  end

  it :from_dynamo_value do
    out = att.from_dynamo_value('2013-11-12T14:15:16+00:00')
    expect(out).to be_a(DateTime)
    expect(out).to eq(dt)
  end

end
