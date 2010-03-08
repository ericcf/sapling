require 'spec_helper.rb'

describe 'shared/content/_list_children' do

  it 'renders links to children' do
    child = mock('content',
      :path => '/foo',
      :title => 'Foo',
      :new_record? => false,
      :updated_at => Date.today)
    assigns[:content] = mock('content', :children => [child])
    render
    response.should have_tag('a[href=/foo]', 'Foo')
  end
end