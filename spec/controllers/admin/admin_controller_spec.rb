$:.unshift File.join(File.dirname(__FILE__), '../..')
require 'spec_helper.rb'

describe Admin::AdminController do

  def fake_authorization
    @controller.stub!(:check_authorization).and_return(true)
  end

  context 'GET index' do

    it 'renders site_page_view partial' do
      fake_authorization
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_view',
             :locals => { :partial => 'admin/index' })
      get :index
    end
  end
end