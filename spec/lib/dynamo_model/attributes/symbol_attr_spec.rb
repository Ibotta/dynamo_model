require 'spec_helper'

describe DynamoModel::Attributes::SymbolAttr do

  let(:att) { DynamoModel::Attributes::SymbolAttr.new(:key_name) }
  let(:sym) { :test }

  it :to_dynamo_value do
    expect(att.to_dynamo_value(sym)).to eq('test')

    mock = double()
    mock.should_receive(:to_sym).and_return(:test_2)
    expect(att.to_dynamo_value(mock)).to eq('test_2')
    #@todo other valid conversions?
  end

  it :from_dynamo_value do
    out = att.from_dynamo_value('test')
    expect(out).to be_a(Symbol)
    expect(out).to eq(sym)

    #should only ever get strings here?
  end

end
