$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Role do

  # database constraints

  it 'enforces name uniqeness at the physical layer' do
    Role.create!(:name => 'Foo')
    duplicate = Role.new(:name => 'Foo')
    lambda {
      duplicate.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  # validation

  it 'is valid with valid attributes' do
    Role.new(:name => 'Foo').should be_valid
  end

  it 'is not valid without a name' do
    Role.new(:name => nil).should_not be_valid
  end

  it 'is not valid with a duplicate name' do
    Role.create!(:name => 'Foo')
    Role.new(:name => 'Foo').should_not be_valid
  end

  # instance methods

  describe '#rights(:state_name)' do

    context 'a stateful right exists' do

      it 'returns an array containing the right when the state name is provided' do
        role = Role.create!(:name => 'Foo')
        state = WorkflowState.create!(:name => 'foo')
        right = Right.create!(:name => 'Foo', :controller => 'Bar', :action => 'Baz')
        StatefulRight.create!(:right => right, :role => role, :workflow_state => state)
        role.rights(state.name).should == [right]
      end
    end

    context 'a stateless right exists' do

      it 'returns an array containing the right when the state name is nil' do
        role = Role.create!(:name => 'Foo')
        state = nil
        right = Right.create!(:name => 'Foo', :controller => 'Bar', :action => 'Baz')
        StatefulRight.create!(:right => right, :role => role, :workflow_state => state)
        role.rights(nil).should == [right]
      end
    end

    context 'no right exists' do

      it 'returns an empty array whatever the state name is' do
        role = Role.create!(:name => 'Foo')
        role.rights(nil).should == []
        role.rights('baz').should == []
      end
    end
  end
end
