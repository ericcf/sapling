require 'spec_helper'
require 'mock_model'

describe ContentAction do
  before(:each) do
    @valid_content = mock_model(MockModel, :valid? => true)
    @valid_user = mock_model(User, :valid? => true)
  end

  it 'is valid with valid attributes' do
    ContentAction.new(:content => @valid_content,
                      :user => @valid_user,
                      :action => 'foo').should be_valid
  end

  it 'is not valid without content' do
    ContentAction.new(:content => nil,
                      :user => @valid_user,
                      :action => 'foo').should_not be_valid
  end

  it 'is not valid without valid content' do
    invalid_content = mock_model(MockModel, :valid? => false)
    ContentAction.new(:content => invalid_content,
                      :user => @valid_user,
                      :action => 'foo').should_not be_valid
  end

  it 'is not valid without a user' do
    ContentAction.new(:content => @valid_content,
                      :user => nil,
                      :action => 'foo').should_not be_valid
  end

  it 'is not valid without a valid user' do
    invalid_user = mock_model(User, :valid? => false)
    ContentAction.new(:content => @valid_content,
                      :user => invalid_user,
                      :action => 'foo').should_not be_valid
  end
end
