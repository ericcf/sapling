$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/fields/view/_string' do

  it 'renders the value' do
    value = 'foo'
    render :locals => { :value => value }
    response.should contain(value)
  end
end
