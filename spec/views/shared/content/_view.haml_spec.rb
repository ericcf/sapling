$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/shared/content/_view' do

  it 'renders partials for sections' do
    page_sections = { :foo => { :partial => {:text => 'foo'} } }
    assigns[:content] = mock('content',
      :title => 'Bar',
      :page_sections => page_sections,
      :schema_fields => [])
    render
    response.capture(:foo).should contain('foo')
  end

  context 'a :view page section is provided for the content type' do

    before(:each) do
      page_sections = { :view => { :partial => { :text => 'foo' } } }
      @content = mock('content',
        :title => 'Bar',
        :page_sections => page_sections,
        :schema_fields => [])
      assigns[:content] = @content
    end

    it 'renders the :view section' do
      template.should_receive(:render).with({ :text => 'foo' })
      render
    end

    it 'does not render the default view' do
      render
      response.should_not contain(@content.title)
    end
  end

  context 'a :view page section is not provided for the content type' do

    it 'renders the default view' do
      page_sections = { }
      schema_fields = [mock('field', :name => :title, :display => 'default', :type => 'string')]
      content = mock('content',
        :title => 'Bar',
        :page_sections => page_sections,
        :schema_fields => schema_fields)
      assigns[:content] = content
      render
      response.should contain(content.title)
    end
  end
end
