require 'spec_helper'

describe DynamoModel::Model::Table do

  let(:testdefn) {
    d = DynamoModel::Definition.new
    d.hash_key :key, :string
    d.table_name :test_table
    d
  }

  describe :definition do
    it "yields definition" do
      class TestDefn1 < DynamoModel::Base; end

      TestDefn1.should_receive(:define_attribute).with(:key)
      TestDefn1.should_receive(:define_attribute_methods).with([:key])
      TestDefn1.definition do |defn|
        defn.hash_key :key, :string
        defn.table_name "test"
      end

      expect(TestDefn1.columns.size).to eq(1)
      expect(TestDefn1.columns[:key]).to_not be_nil
      expect(TestDefn1.table_name).to eq('test')

    end
    it "doesnt break when there are multiple" do
      class TestDefn2 < DynamoModel::Base; end

      TestDefn2.should_receive(:define_attribute).with(:key)
      TestDefn2.should_receive(:define_attribute_methods).with([:key])
      TestDefn2.definition do |defn|
        defn.hash_key :key, :string
        defn.table_name "test"
      end

      class TestDefn3 < DynamoModel::Base; end

      TestDefn3.columns.should be_nil

      TestDefn3.should_receive(:define_attribute).with(:key2)
      TestDefn3.should_receive(:define_attribute_methods).with([:key2])
      TestDefn3.definition do |defn|
        defn.hash_key :key2, :string
        defn.table_name "test2"
      end

      expect(TestDefn3.columns.size).to eq(1)
      expect(TestDefn3.columns[:key2]).to_not be_nil
      expect(TestDefn3.table_name).to eq('test2')

      #retest and hope its right
      expect(TestDefn2.columns.size).to eq(1)
      expect(TestDefn2.columns[:key]).to_not be_nil
      expect(TestDefn2.table_name).to eq('test')

    end

    it "takes an exisiting defn" do
      class TestDefn4 < DynamoModel::Base; end

      TestDefn4.should_receive(:define_attribute).with(:key)
      TestDefn4.should_receive(:define_attribute_methods).with([:key])

      TestDefn4.definition(testdefn)

      expect(TestDefn4.columns.size).to eq(1)
      expect(TestDefn4.columns[:key]).to_not be_nil

    end

    it "raises on invalid" do
      class TestDefn5 < DynamoModel::Base; end

      TestDefn5.should_receive(:define_attribute).never
      TestDefn5.should_receive(:define_attribute_methods).never

      d = double()
      d.should_receive(:valid?).and_return(:false)

      expect { TestDefn4.definition(d) }.to raise_error

    end

  end

  describe :define_attribute do

    it "defines a reader and writer" do
      class TestDefn6 < DynamoModel::Base; end

      TestDefn6.send(:define_attribute, :test)
      expect(TestDefn6).to be_method_defined(:test)
      expect(TestDefn6).to be_method_defined(:test=)

      d = TestDefn6.new
      d.should_receive(:read_attribute).with(:test).and_return('abc')
      expect(d.test).to eq('abc')

      d.should_receive(:write_attribute).with(:test, 'abc')
      expect((d.test = 'abc')).to eq('abc')
    end

  end

end
