$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/chunks/_new' do

  it 'renders admin/chunks/_form partial' do
    assigns[:section] = mock_model(Section, :name => 'foo')
    template.should_receive(:render).
      with(:partial => 'admin/chunks/form',
           :locals => { :action => 'create', :f_method => :post })
    render
  end
end
