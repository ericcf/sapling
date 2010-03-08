$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/sections/_edit' do

  it 'renders admin/sections/_form partial' do
    template.should_receive(:render).
      with(:partial => 'admin/sections/form',
           :locals => { :f_method => :put })
    render
  end
end
