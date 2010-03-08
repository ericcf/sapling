$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Event do

  it 'is valid with valid attributes' do
    Event.new(:title => 'Foo',
      :text => 'Bar',
      :start_at => Time.now,
      :end_at => Time.now + 1,
      :slug => 'foo').should be_valid
  end

  it 'is not valid without a start time' do
    Event.new(:title => 'Foo',
      :text => 'Bar',
      :start_at => nil,
      :end_at => Time.now + 1,
      :slug => 'foo').should_not be_valid
  end

  it 'is not valid without an end time' do
    Event.new(:title => 'Foo',
      :text => 'Bar',
      :start_at => Time.now,
      :end_at => nil,
      :slug => 'foo').should_not be_valid
  end

  it 'is not valid with an end time before the start time' do
    start_time = Time.now
    Event.new(:title => 'Foo',
      :text => 'Bar',
      :start_at => start_time,
      :end_at => start_time - 1000,
      :slug => 'foo').should_not be_valid
  end

  it 'is valid with an end time equal to the start time' do
    start_time = Time.now
    Event.new(:title => 'Foo',
      :text => 'Bar',
      :start_at => start_time,
      :end_at => start_time,
      :slug => 'foo').should be_valid
  end
end
