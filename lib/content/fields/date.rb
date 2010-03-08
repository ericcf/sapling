module Content

  module Fields

		class Date < Field

			def self.type
				'date'
			end

			def self.edit_type
				'date_select_field'
			end
		end

		Content::Fields::Field.register Date
	end
end

