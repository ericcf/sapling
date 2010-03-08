$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/chunks/_edit' do

  it 'renders admin/chunks/_form partial' do
    template.should_receive(:render).
      with(:partial => 'admin/chunks/form',
           :locals => { :action => 'update', :f_method => :put })
    render
  end
end
