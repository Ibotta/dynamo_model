require 'spec_helper'

describe DynamoModel::Definition do

  let(:defn) { DynamoModel::Definition.new }

  it "processes definiton hash on initialize"

  it :table_name do
    defn.table_name 'test_name'
    expect(defn.table_name).to eq('test_name')
  end

  it :capacity do
    defn.capacity 3, 4
    expect(defn.capacity).to eq({read: 3, write: 4})
  end

  describe :valid? do
    it "valid" do
      defn.hash_key :hk, :string
      defn.range_key :rk, :string
      expect(defn.valid?).to be_true
    end
    it "no keys" do
      expect(defn.valid?).to be_false
    end
    it "invalid keys" do
      defn.integer :i
      defn.float :f
      expect(defn.valid?).to be_false
    end
  end

  describe "hash keys" do
    it :hash_key do
      defn.should_receive(:string).with(:key_name, { option: 'value' })
      defn.hash_key(:key_name, :string, option: 'value')
      expect(defn.keys[:hash]).to eq(:key_name)
    end
    it :range_key do
      defn.should_receive(:string).with(:key_name, { option: 'value' })
      defn.range_key(:key_name, :string, option: 'value')
      expect(defn.keys[:range]).to eq(:key_name)
    end
  end

  describe "attribute types" do
    it :attribute do
      defn.should_receive(:string).with(:key_name, { option: 'value' })
      defn.attribute(:key_name, :string, option: 'value')
    end
    it :string do
      defn.string :key_name, option: 'value'
      expect(defn.attrs[:key_name]).to be_a(DynamoModel::Attributes::StringAttr)
      expect(defn.attrs[:key_name].name).to eq(:key_name)
      expect(defn.attrs[:key_name].opts).to eq({:option => 'value'})
    end
    it :symbol do
      defn.symbol :key_name, option: 'value'
      expect(defn.attrs[:key_name]).to be_a(DynamoModel::Attributes::SymbolAttr)
      expect(defn.attrs[:key_name].name).to eq(:key_name)
      expect(defn.attrs[:key_name].opts).to eq({:option => 'value'})
    end
    it :integer do
      defn.integer :key_name, option: 'value'
      expect(defn.attrs[:key_name]).to be_a(DynamoModel::Attributes::IntegerAttr)
      expect(defn.attrs[:key_name].name).to eq(:key_name)
      expect(defn.attrs[:key_name].opts).to eq({:option => 'value'})
    end
    it :float do
      defn.float :key_name, option: 'value'
      expect(defn.attrs[:key_name]).to be_a(DynamoModel::Attributes::FloatAttr)
      expect(defn.attrs[:key_name].name).to eq(:key_name)
      expect(defn.attrs[:key_name].opts).to eq({:option => 'value'})
    end
    it :datetime do
      defn.datetime :key_name, option: 'value'
      expect(defn.attrs[:key_name]).to be_a(DynamoModel::Attributes::DatetimeAttr)
      expect(defn.attrs[:key_name].name).to eq(:key_name)
      expect(defn.attrs[:key_name].opts).to eq({:option => 'value'})
    end
    it :timestamps do
      defn.timestamps option: 'value'
      expect(defn.attrs[:created_at]).to be_a(DynamoModel::Attributes::DatetimeAttr)
      expect(defn.attrs[:updated_at]).to be_a(DynamoModel::Attributes::DatetimeAttr)
    end
    it "set types"
    it "binary types?"
  end

end
