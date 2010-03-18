require 'spec_helper'

describe TagCollectionsHelper do

  describe '#add_tag_link' do

    it 'returns a link to a function to add a tag' do
      helper.stub!(:render)
      helper.add_tag_link('Foo', 'bar').should have_tag('a', 'Foo')
    end
  end
end