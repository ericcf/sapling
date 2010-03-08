require 'spec_helper.rb'

describe '/shared/fields/edit/_reference_selection_form' do

  before(:each) do
    template.stub!(:content_types).and_return([])
    assigns[:node_list] = WillPaginate::Collection.new(1, 1, 1)
  end

  it 'renders links for filtering results by content type' do
    template.stub!(:content_types).and_return(['Foo'])
    render
    response.should have_tag('a', :text => 'Foo')
  end

  it 'renders links for selecting content items' do
    content = double('content', :title => 'Foo')
    node = double('node', :content => content, :path => '/foo')
    assigns[:node_list] << node
    render
    response.should have_tag('a', :text => 'Foo')
  end
end
