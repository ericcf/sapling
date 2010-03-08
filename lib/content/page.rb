module Content

  class Page

    attr_reader :sections

    def initialize
      @sections = {}
    end

    def method_missing(symbol, partial)
      @sections[symbol] = { :partial => partial }
    end
  end
end