$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe TagCollection do

  before(:each) do
    @collection = TagCollection.new(:label => 'Foo Tags')
  end

  it 'is valid with valid attributes' do
    @collection.should be_valid
  end

  it 'is not valid without a label' do
    TagCollection.new(:label => nil).should_not be_valid
  end

  it 'is not valid with invalid tags' do
    invalid_tag = Tag.create!(:label => 'Foo')
    invalid_tag.stub!(:valid?).and_return(false)
    @collection.should be_valid
    @collection.tags << invalid_tag
    @collection.should_not be_valid
  end

  context 'after updating' do

    it 'saves the tags without validation' do
      @collection.save!
      tag = mock_model(Tag)
      @collection.stub!(:tags).and_return([tag])
      tag.should_receive(:save).with(false)
      @collection.update_attribute(:label, 'Bar Tags')
    end
  end

  context 'when destroying' do

    it 'destroys associated tags' do
      tag = mock_model(Tag)
      @collection.stub!(:tags).and_return([tag])
      tag.should_receive(:destroy)
      @collection.destroy
    end
  end

  describe '#top_level_tags' do

    it 'returns tags without parents' do
      parent_tag = mock_model(Tag, :parent => nil)
      child_tag = mock_model(Tag, :parent => parent_tag)
      @collection.stub!(:tags).and_return([parent_tag, child_tag])
      @collection.top_level_tags.should == [parent_tag]
    end
  end

  describe '#new_tag_attributes=(:tag_attributes)' do

    it 'builds tags based on the attributes' do
      tags = mock('tags')
      @collection.stub!(:tags).and_return(tags)
      tags.should_receive(:build).with(:foo => 'bar')
      @collection.new_tag_attributes = [{ :foo => 'bar' }]
    end
  end

  describe '#existing_tag_attributes=(:tag_attributes)' do

    context 'for new tags' do

      it 'does nothing' do
        new_tag = mock_model(Tag, :new_record? => true)
        @collection.stub!(:tags).and_return([new_tag])
        new_tag.should_not_receive(:attributes)
        new_tag.should_not_receive(:delete)
        @collection.existing_tag_attributes = { new_tag.id.to_s => { :foo => 'bar' } }
      end
    end

    context 'for existing tags' do

      before(:each) do
        @existing_tag = mock_model(Tag, :new_record? => false)
        @tags = [@existing_tag]
        @collection.stub!(:tags).and_return(@tags)
      end

      context 'when attributes are provided' do

        it 'updates the tag attributes' do
          @existing_tag.should_receive(:attributes=).with(:foo => 'bar')
          @collection.existing_tag_attributes = { @existing_tag.id.to_s => { :foo => 'bar' } }
        end
      end

      context 'when attributes are not provided' do

        it 'deletes the tag' do
          @tags.should_receive(:delete).with(@existing_tag)
          @collection.existing_tag_attributes = {}
        end
      end
    end
  end
end
