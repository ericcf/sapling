$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe ContentHelper do

  describe '#content_types' do

    it 'returns TreeNodeContent types' do
      helper.content_types.should == TreeNodeContent::Item.types
    end
  end

  describe '#title' do

    context '@content has a title attribute' do

      it 'returns @content.title' do
        content = double('content', :title => 'Foo')
        assigns[:content] = content
        helper.title.should == content.title
      end
    end

    context '@content doesn\'t have a title attribute' do

      it 'returns default' do
        content = double('content')
        assigns[:content] = content
        helper.title.should == 'Sapling: Welcome'
      end
    end
  end

  describe '#menu_items' do

    it 'returns [] when no root node exists' do
      TreeNodeContent::Item.stub!(:find_by_path).with('/').and_return(nil)
      helper.menu_items.should == []
    end
  end

  describe '#breadcrumbs(:content)' do

    it 'returns if :content is nil' do
      helper.breadcrumbs(nil).should be_nil
    end
  end

  describe '#internal_link_to(:content)' do

    it 'returns nil if :content is a new record' do
      content = double('content', :new_record? => true)
      helper.internal_link_to(content).should be_nil
    end

    it 'returns a link to :content' do
      content = double('content', :new_record? => false, :title => 'Foo',
        :path => '/foo')
      helper.internal_link_to(content).should ==
        link_to(content.title, content.path)
    end

    it 'applies selected class if :content == @content' do
      content = double('content', :new_record? => false, :title => 'Foo',
        :path => '/foo')
      assigns[:content] = content
      helper.internal_link_to(content).should ==
        link_to(content.title, content.path, { :class => 'selected' })
    end
  end
end