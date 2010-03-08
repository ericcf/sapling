$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Page do

  it 'is valid with valid attributes' do
    Page.new(:title => 'Foo',
      :text => 'Bar',
      :slug => 'foo').should be_valid
  end
end
