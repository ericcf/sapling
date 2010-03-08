$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'
require 'mock_model'

describe TagAssociation do

  before(:each) do
    @valid_tag = mock_model(Tag, :valid? => true)
    @valid_content = mock_model(MockModel, :valid? => true)
  end

  it 'is valid with valid attributes' do
    TagAssociation.new(:tag => @valid_tag,
      :content => @valid_content).should be_valid
  end

  it 'is not valid without a tag' do
    TagAssociation.new(:tag => nil,
      :content => @valid_content).should_not be_valid
  end

  it 'is not valid without a valid tag' do
    invalid_tag = mock_model(Tag, :valid? => false)
    TagAssociation.new(:tag => invalid_tag,
      :content => @valid_content).should_not be_valid
  end

  it 'is not valid without content' do
    TagAssociation.new(:tag => @valid_tag,
      :content => nil).should_not be_valid
  end

  it 'is not valid without valid content' do
    invalid_content = mock_model(MockModel, :valid? => false)
    TagAssociation.new(:tag => @valid_tag,
      :content => invalid_content).should_not be_valid
  end
end
