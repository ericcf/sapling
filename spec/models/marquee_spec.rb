require 'spec_helper'

describe Marquee do

  describe '#after_initialize' do

    it 'builds a new associated Slide if none are associated' do
      slide = mock_model(Slide)
      Slide.should_receive(:new).and_return(slide)
      marquee = Marquee.new
      marquee.slides.should == [slide]
    end
  end

  describe '#new_slide_attributes=(:slide_attributes)' do

    it 'builds new slides based on the passed attributes' do
      marquee = Marquee.new
      Slide.should_receive(:new).with(:title => 'Foo')
      marquee.new_slide_attributes = [{ :title => 'Foo' }]
    end
  end

  describe '#existing_slide_attributes=(:slide_attributes)' do

    before(:each) do
      @marquee = Marquee.new
      @slide = mock_model(Slide, :new_record? => false)
      @slides = [@slide]
      @marquee.stub!(:slides).and_return(@slides)
    end

    it 'updates attributes of slides whose ids are included' do
      @slide.should_receive(:attributes=).with(:title => 'Foo')
      @marquee.existing_slide_attributes = { @slide.id.to_s => {:title => 'Foo'} }
    end

    it 'deletes slides whose ids are not included' do
      @slides.should_receive(:delete).with(@slide)
      @marquee.existing_slide_attributes = { }
    end
  end

  describe '#save_slides' do

    it 'saves associated slides without validation' do
      marquee = Marquee.new
      slide = mock_model(Slide)
      marquee.stub!(:slides).and_return([slide])
      slide.should_receive(:save).with(false)
      marquee.save_slides
    end
  end
end