require 'spec_helper'

describe DynamoModel::Attributes::NumberAttr do

  let(:att) { DynamoModel::Attributes::NumberAttr.new(:key_name) }

  it "DYNAMO_TYPE" do
    expect(DynamoModel::Attributes::NumberAttr::DYNAMO_TYPE).to eq('N')
  end

end
