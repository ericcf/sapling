module Content

  module Fields

		class HasMany < Field

			def self.type
				'has_many'
			end

			def self.edit_type
				'has_many_field'
			end

			def child_classname
				@other[:child_classname]
			end
		end

		Field.register HasMany
	end
end

