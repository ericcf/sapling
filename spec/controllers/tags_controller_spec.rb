$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe TagsController do

  context 'POST create_association' do

    before(:each) do
      @association = mock_model(TagAssociation, :save => nil)
    end

    it 'creates a new TagAssociation' do
      TagAssociation.should_receive(:new).
        with('foo' => 'bar').
        and_return(@association)
      post :create_association, :tag_association => { :foo => 'bar' }
    end

    it 'saves the record' do
      TagAssociation.stub!(:new).and_return(@association)
      @association.should_receive(:save)
      post :create_association, :tag_association => {}
    end
  end

  context 'POST destroy_association' do

    before(:each) do
      @association = mock_model(TagAssociation, :save => nil)
    end

    it 'destroys a TagAssociation' do
      TagAssociation.stub!(:find).
        with(:first, :conditions => { 'foo' => 'bar' }).
        and_return(@association)
      @association.should_receive(:destroy)
      post :destroy_association, :tag_association => { :foo => 'bar' }
    end
  end
end