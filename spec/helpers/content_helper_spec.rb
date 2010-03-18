$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe ContentHelper do

  describe '#content_types' do

    it 'returns Content types' do
      helper.content_types.should == Content.types
    end
  end

  describe '#title' do

    context '@content has a title attribute' do

      it 'returns @content.title' do
        content = mock('content', :title => 'Foo')
        assigns[:content] = content
        helper.title.should == content.title
      end
    end

    context '@content doesn\'t have a title attribute' do

      it 'returns default' do
        content = mock('content')
        assigns[:content] = content
        helper.title.should == 'Sapling: Welcome'
      end
    end
  end

  describe '#internal_link_to(:content)' do

    it 'returns nil if :content is a new record' do
      content = mock('content', :new_record? => true)
      helper.internal_link_to(content).should be_nil
    end

    it 'returns a link to :content' do
      content = mock('content', :new_record? => false, :title => 'Foo',
        :path => '/foo')
      helper.internal_link_to(content).should ==
        link_to(content.title, content.path)
    end

    it 'applies selected class if :content == @content' do
      content = mock('content', :new_record? => false, :title => 'Foo',
        :path => '/foo')
      assigns[:content] = content
      helper.internal_link_to(content).should ==
        link_to(content.title, content.path, { :class => 'selected' })
    end
  end

  describe 'content action methods' do

    before(:each) do
      @content_actions = mock('actions')
      content = mock('content', :content_actions => @content_actions)
      assigns[:content] = content
    end

    describe '#content_creation' do

      context 'there is an associated creation ContentAction' do

        it 'returns the creation ContentAction for the context content' do
          user = mock_model(User)
          date = Date.today
          created = mock_model(ContentAction, :user => user, :created_at => date)
          @content_actions.stub!(:find).
            with(:first, :conditions => { :action => ContentAction::CREATED }).
            and_return(created)
          helper.content_creation.should == { :user => user, :date => date }
        end
      end

      context 'there is no associated creation ContentAction' do

        it 'returns nil' do
          @content_actions.stub!(:find)
          helper.content_creation.should be_nil
        end
      end
    end

    describe '#last_content_modification' do

      context 'there is an associated modification ContentAction' do

        it 'returns the last modification ContentAction for the context content' do
          user = mock_model(User)
          date = Date.today
          last_modified = mock_model(ContentAction, :user => user, :created_at => date)
          @content_actions.stub!(:find).
            with(:last, :conditions => { :action => ContentAction::MODIFIED }, :order => 'created_at').
            and_return(last_modified)
          helper.last_content_modification.should == { :user => user, :date => date }
        end
      end

      context 'there is no associated modification ContentAction' do

        it 'returns nil' do
          @content_actions.stub!(:find)
          helper.last_content_modification.should be_nil
        end
      end
    end
  end
end