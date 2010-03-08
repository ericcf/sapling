class Enclosure

  attr_reader :url, :length, :type

end

class FeedItem

  attr_reader :title, :link, :description, :author, :comments, :category
  attr_reader :enclosure, :pubDate, :guid

  def initialize(attributes)
    
  end

end

class RSSFeed

  attr_reader :items, :title, :link, :description, :language, :pubDate
  attr_reader :lastBuildDate, :category, :ttl, :image, :managingEditor
  attr_reader :webMaster

  def initialize(attributes)
    @items = attributes.include?(:items) ? attributes[:items] : []
    @title = attributes[:title]
    @link = attributes[:link]
    @description = attributes[:description]
  end

end