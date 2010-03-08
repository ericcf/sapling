module Content

  module Fields

		class String < Field

			def self.type
				'string'
			end

			def self.edit_type
				'text_field'
			end
		end

		Content::Fields::Field.register String
	end
end
