require File.dirname(__FILE__) + '/../../../spec_helper.rb'

describe '/shared/forms/_submit_cancel' do

  it 'renders the cancel link' do
    render :locals => { :cancel_url => '/foo', :cancel_label => 'Cancel' }
    response.should have_tag('a[href=/foo]', :text => 'Cancel')
  end
end
