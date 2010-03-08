$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/fields/view/_uri' do

  it 'renders a link' do
    value = '/foo'
    field = mock('field', :label => 'Foo')
    render :locals => { :value => value, :field => field }
    response.should have_tag("a[href=#{value}]", :text => field.label)
  end
end
