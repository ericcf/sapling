require 'spec_helper.rb'
require 'mock_model'

describe '/shared/site/site_page_edit' do

  it 'renders shared/content/_edit' do
    content_actions = mock('actions')
    content_actions.stub!(:find)
    assigns[:content] = mock_model(MockModel,
                                   :schema_fields => [],
                                   :parent => nil,
                                   :title => 'Foo',
                                   :path => '/foo',
                                   :content_actions => content_actions,
                                   :workflow_state => nil)
    assigns[:action_url] = '/foo'
    template.should_receive(:render).
            with(:partial => 'shared/content/edit', :locals => { :f_method => :post })
    render :locals => { :f_method => :post }
  end
end

