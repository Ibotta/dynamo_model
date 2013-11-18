require 'spec_helper'

describe DynamoModel::Model::Attributes do

  let(:base) { DynamoModel::Base.new }

  it :read_attribute do
    base.instance_variable_set(:@attributes, {col: 'test'})

    expect(base.read_attribute(:col)).to eq('test')
    expect(base.read_attribute('col')).to eq('test')
  end

  it :write_attribute do
    base.should_receive(:attribute_will_change!).with(:col)

    base.write_attribute(:col, 'test')

    expect(base.instance_variable_get(:@attributes)[:col]).to eq('test')
  end

  it :attributes do
    base.instance_variable_set(:@attributes, {col: 'test', col2: 'test2'})
    base.should_receive(:read_attribute).with(:col).and_return('test')
    base.should_receive(:read_attribute).with(:col2).and_return('test2')

    expect(base.attributes).to eq({col: 'test', col2: 'test2'})
  end

  it :attributes= do
    base.should_receive(:write_attribute).with(:col, 'test')
    base.should_receive(:write_attribute).with(:col2, 'test2')

    base.attributes={col: 'test', col2: 'test2'}
  end

end
