xml.rss(:version => "2.0") do
  xml.channel do
    xml.title
    xml.link
    xml.description
    xml.language
    xml.pubDate
    xml.lastBuildDate
    xml.docs
    xml.generator
    xml.managingEditor
    xml.webMaster
    @items.each do |item|
      xml.item do
        xml.title
        xml.link
        xml.description
        xml.pubDate
        xml.guid
      end
    end
  end
end