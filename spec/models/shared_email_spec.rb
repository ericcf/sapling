$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'
require 'mock_model'

describe SharedEmail do

  before(:each) do
    MockModel.stub!(:find)
  end

  it 'is valid with valid attributes' do
    SharedEmail.new(:recipient => 'Foo',
      :sender => 'Bar',
      :content_id => 1,
      :content_type => 'MockModel').should be_valid
  end

  it 'is not valid without a recipient' do
    SharedEmail.new(:recipient => nil,
      :sender => 'Bar',
      :content_id => 1,
      :content_type => 'MockModel').should_not be_valid
  end

  it 'is not valid without content_id or content_type' do
    SharedEmail.new(:recipient => 'Foo',
      :sender => 'Bar',
      :content_id => nil,
      :content_type => 'Foo').should_not be_valid
    SharedEmail.new(:recipient => 'Foo',
      :sender => 'Bar',
      :content_id => 1,
      :content_type => nil).should_not be_valid
  end

  it 'is not valid without valid content' do
    content = mock_model(MockModel, :valid? => false)
    SharedEmail.new(:recipient => 'Foo',
      :sender => 'Bar',
      :content => content).should_not be_valid
  end
end
