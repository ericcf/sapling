$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/fields/view/_image' do

  context 'file_size is not nil' do

    it 'renders an image tag' do
      assigns[:content] = mock('content', :foo_file_size => 1)
      value = mock('image', :name => 'foo', :url => '/foo')
      render :locals => { :value => value }
      response.should have_tag('img')
    end
  end

  context 'file_size is nil' do

    it 'renders nothing' do
      assigns[:content] = mock('content', :foo_file_size => nil)
      value = mock('image', :name => 'foo')
      render :locals => { :value => value }
      response.should_not have_tag('img')
    end
  end
end
