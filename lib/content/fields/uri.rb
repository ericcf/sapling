module Content

  module Fields

		class URI < Field

			def self.type
				'uri'
			end

			def self.edit_type
				'text_field'
			end
		end

		Field.register URI
	end
end

