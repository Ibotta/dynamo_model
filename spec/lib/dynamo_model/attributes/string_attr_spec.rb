require 'spec_helper'

describe DynamoModel::Attributes::StringAttr do

  let(:att) { DynamoModel::Attributes::StringAttr.new(:key_name) }

  it "DYNAMO_TYPE" do
    expect(DynamoModel::Attributes::StringAttr::DYNAMO_TYPE).to eq('S')
  end

end
