puts 'seeding page sections. . .'

above_content = Section.create(:name => 'above_content')
Chunk.create(:name => 'first', :section => above_content, :section_index => 0)