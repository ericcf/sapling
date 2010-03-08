$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/users/_new' do

  it 'renders admin/users/_form' do
    template.should_receive(:render).
      with(:partial => 'admin/users/form',
           :locals => { :f_method => :post })
    render
  end
end
