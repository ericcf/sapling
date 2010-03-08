module Content

  module Fields

		class Image < Field

			def self.type
				'image'
			end

			def self.edit_type
				'image_upload_field'
			end

			def is_file_field?
				true
			end
		end

		Field.register Image
	end
end

