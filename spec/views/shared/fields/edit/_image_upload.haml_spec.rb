require 'spec_helper.rb'

describe '/shared/fields/edit/_image_upload' do

  before(:each) do
    @image = double('image')
    @image.stub!(:url).with(:thumb).and_return('/images/foo.jpg')
    content = double('content')
    assigns[:content] = content
    assigns[:content].stub!(:image).and_return(@image)
    assigns[:content].stub!(:image_file_size)
    form = ActionView::Helpers::FormBuilder.new(:content, content, template, {}, nil)
    @locals = { :label => 'Image', :form => form, :field_name => :image }
  end

  context 'an image exists' do

    before(:each) do
      assigns[:content].stub!(:image_file_size).and_return(100)
    end

    it 'renders the image as a thumbnail' do
      render :locals => @locals
      response.should have_selector('img', :src => @image.url(:thumb))
    end

    it 'renders a checkbox for deleting the image' do
      render :locals => @locals
      response.should have_selector('input',
        :type => 'checkbox',
        :name => 'content[image_delete]'
      )
    end
  end
end
