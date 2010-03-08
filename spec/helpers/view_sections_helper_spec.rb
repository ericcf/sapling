$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe ViewSectionsHelper do

  describe '#draw(:section_name)' do

    context 'the Section is found' do

      it 'renders the section chunks' do
        section = mock_model(Section, :chunks => [], :name => 'foo')
        Section.stub!(:find_by_name).with(section.name).and_return(section)
        helper.should_receive(:render).
          with(:partial => 'shared/site/sections/section',
               :locals => { :section => section.name.to_sym,
                            :chunks => section.chunks })
        helper.draw(section.name)
      end
    end

    context 'the Section is not found' do

      it 'renders the section partial' do
        Section.stub!(:find_by_name).and_return(nil)
        helper.should_receive(:render).
          with(:partial => 'shared/site/sections/foo')
        helper.draw('foo')
      end
    end
  end
end