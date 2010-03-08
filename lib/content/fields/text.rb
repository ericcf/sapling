module Content

  module Fields

		class Text < Field

			def self.type
				'text'
			end

			def self.edit_type
				'rich_text_area'
			end
		end

		Field.register Text
	end
end

