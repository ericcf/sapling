$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/sections/_new' do

  it 'renders admin/sections/_form' do
    template.should_receive(:render).
      with(:partial => 'admin/sections/form',
           :locals => { :f_method => :post })
    render
  end
end
