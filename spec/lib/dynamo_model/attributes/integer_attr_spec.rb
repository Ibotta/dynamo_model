require 'spec_helper'

describe DynamoModel::Attributes::IntegerAttr do

  let(:att) { DynamoModel::Attributes::IntegerAttr.new(:key_name) }
  let(:i) { 123 }

  it :to_dynamo_value do
    expect(att.to_dynamo_value(i)).to eq('123')

    mock = double()
    mock.should_receive(:to_i).and_return(234)
    expect(att.to_dynamo_value(mock)).to eq('234')
    #@todo other valid conversions?
  end

  it :from_dynamo_value do
    out = att.from_dynamo_value('123')
    expect(out).to be_a(Integer)
    expect(out).to eq(i)

    #should only ever get strings here?
  end

end
