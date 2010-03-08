$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/fields/view/_content_reference' do

  it 'renders a link to the referenced content' do
    value = mock('content', :title => 'foo', :path => '/foo' )
    render :locals => { :value => value }
    response.should have_tag("a[href=#{value.path}]", :text => value.title)
  end
end
