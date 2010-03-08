require 'spec_helper.rb'

describe '/shared/site/site_page_edit' do

  it 'renders shared/content/_edit' do
		assigns[:content] = mock('content', :schema_fields => [])
		assigns[:action_url] = '/foo'
		template.should_receive(:render).
			with(:partial => 'shared/content/edit', :locals => { :f_method => :post })
		render :locals => { :f_method => :post }
	end
end

