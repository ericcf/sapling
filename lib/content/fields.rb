# require this file to use Field and its subclasses
#
module Content
  module Fields
  end
end
require 'content/fields/field.rb'
Dir.glob(File.join(File.dirname(__FILE__), 'fields', '*.rb')).each do |f|
	require f unless f.split('/').last == 'field.rb'
end
