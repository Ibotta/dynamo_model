require 'spec_helper'

describe DynamoModel::Attributes::FloatAttr do

  let(:att) { DynamoModel::Attributes::FloatAttr.new(:key_name) }
  let(:f) { 123.4567 }

  it :to_dynamo_value do
    expect(att.to_dynamo_value(f)).to eq('123.4567')

    mock = double()
    mock.should_receive(:to_f).and_return(2.34)
    expect(att.to_dynamo_value(mock)).to eq('2.34')
  end

  it :from_dynamo_value do
    out = att.from_dynamo_value('123.4567')
    expect(out).to be_a(Float)
    expect(out).to eq(f)

    #should only ever get strings here?
  end

end
