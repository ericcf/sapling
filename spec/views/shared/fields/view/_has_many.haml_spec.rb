$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/fields/view/_has_many' do

  it 'renders the title of each item' do
    value = [mock('content', :title => 'Foo')]
    render :locals => { :value => value }
    response.should contain('Foo')
  end
end
