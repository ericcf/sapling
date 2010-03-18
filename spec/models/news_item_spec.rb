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

  describe '#image_delete=(:value)' do

    it 'destroys the attached image for value = "1"' do
      news_item = NewsItem.new
      image = mock('image')
      news_item.stub!(:image).and_return(image)
      image.should_receive(:destroy)
      news_item.image_delete = '1'
    end
  end
end
