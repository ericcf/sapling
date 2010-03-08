$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe NewsItem do

  it 'is valid with valid attributes' do
    NewsItem.new(:slug => 'foo',
      :title => 'Foo',
      :text => 'Bar',
      :author_id => 2,
      :external_uri => 'http://foo.bar',
      :publish_date => Time.now).should be_valid
  end
end
