class MockModel
	def self.base_class; self end
	def id; end
	def save(options={}); true end
	def valid?; true end
	def destroyed?; false end
	def new_record?; true end
	def self.method_missing(symbol, *args, &block); end
	def method_missing(symbol, *args, &block); end
end
