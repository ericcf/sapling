$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe User do

  it 'is valid with valid attributes' do
    User.new(:username => 'Foo',
      :password => 'Bar',
      :password_confirmation => 'Bar').should be_valid
  end

  it 'is not valid with a missing username' do
    User.new(:username => nil,
      :password => 'Bar',
      :password_confirmation => 'Bar').should_not be_valid
  end

  it 'is not valid with a duplicate username' do
    User.create!(:username => 'Foo',
      :password => 'Bar',
      :password_confirmation => 'Bar')
    User.new(:username => 'Foo',
      :password => 'Baz',
      :password_confirmation => 'Baz').should_not be_valid
  end

  it 'is not valid with a missing password' do
    User.new(:username => 'Foo',
      :password => nil,
      :password_confirmation => nil).should_not be_valid
  end

  it 'is not valid with a blank password' do
    User.new(:username => 'Foo',
      :password => '',
      :password_confirmation => '').should_not be_valid
  end

  it 'is not valid with an unconfirmed password' do
    User.new(:username => 'Foo',
      :password => 'Bar',
      :password_confirmation => 'Baz').should_not be_valid
  end

  context 'when authenticating' do

    before(:each) do
      @user = User.create!(:username => 'Foo',
        :password => 'Bar',
        :password_confirmation => 'Bar')
    end

    it 'fails with a missing password' do
      User.authenticate(:username => 'Foo', :password => nil).should be_nil
    end

    it 'fails with a blank password' do
      User.authenticate(:username => 'Foo', :password => '').should be_nil
    end

    it 'fails with an incorrect password' do
      User.authenticate(:username => 'Foo', :password => 'Baz').should be_nil
    end

    it 'succeeds with the correct password' do
      User.authenticate(:username => 'Foo', :password => 'Bar').should == @user
    end
  end

  context 'when updating' do

    before(:each) do
      @user = User.create!(:username => 'Foo',
        :password => 'Bar',
        :password_confirmation => 'Bar')
    end

    it 'succeeds with valid attributes' do
      old_hash = @user.password_hash
      @user.update_attributes(:current_password => 'Bar',
        :password => 'Baz',
        :password_confirmation => 'Baz').should == true
      @user.password_hash.should_not == old_hash
    end

    it 'fails if current_password is incorrect' do
      @user.update_attributes(:current_password => 'Barf',
        :password => 'Baz',
        :password_confirmation => 'Baz').should == false
    end

    it 'does not change the password if it is blank' do
      old_hash = @user.password_hash
      @user.update_attributes(:current_password => 'Bar',
        :password => '',
        :password_confirmation => '')
      @user.password_hash.should == old_hash
    end
  end

  describe '#title' do

    it 'returns the username' do
      User.new(:username => 'Foo').title.should == 'Foo'
    end
  end
end
