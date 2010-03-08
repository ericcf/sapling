require 'spec_helper.rb'

describe '/shared/content/_edit' do

  before(:each) do
    assigns[:action_url] = '/foo'
    assigns[:content] = mock('content', :schema_fields => [], :id => 1)
    @locals = { :f_method => :foo }
  end

  it 'renders a hidden field with the class name' do
    class Foo
      def model_name; 'foo' end
    end
    assigns[:content].stub!(:class).and_return(Foo)
    render :locals => @locals
    response.should have_tag('input[type=hidden][name=new_type][value=Foo]')
  end

  context 'content has a file field' do

    it 'renders a multipart form' do
      schema_fields = [
        mock('field', :edit_type => 'text_field', :name => :title,
          :is_file_field? => true, :label => 'foo', :required => false)
      ]
      assigns[:content] = mock('content', :schema_fields => schema_fields,
        :id => 1, :title => 'Foo', :errors => mock_model(ActiveRecord::Errors).as_null_object)
      render :locals => @locals
      response.should have_tag('form[enctype=multipart/form-data]')
    end
  end

  it 'renders the submit button' do
    render :locals => @locals
    response.should have_tag('input[type=submit]')
  end
end
