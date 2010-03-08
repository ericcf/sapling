module Content

  module Fields

		class ContentReference < Field

			def self.type
				'content_reference'
			end

			def self.edit_type
				'content_reference_field'
			end
		end

		Field.register ContentReference
	end
end

