xml.rss(:version => "2.0") do
  xml.channel do
    xml.title @feed.title
    xml.link @feed.link
    xml.description @feed.description
    xml.language @feed.language if @feed.language
    xml.pubDate @feed.pubDate if @feed.pubDate
    xml.lastBuildDate @feed.lastBuildDate if @feed.lastBuildDate
    xml.category @feed.category if @feed.category
    xml.docs 'http://blogs.law.harvard.edu/tech/rss'
    xml.ttl @feed.ttl if @feed.ttl
    if @feed.image
      xml.image do
        xml.url @feed.image.url
        xml.title @feed.title
        xml.link @feed.link
        xml.width @feed.image.with if @feed.image.width
        xml.height @feed.image.height if @feed.image.height
        xml.description @feed.image.description if @feed.image.description
      end
    end
    xml.generator 'Sapling'
    xml.managingEditor @feed.managingEditor if @feed.managingEditor
    xml.webMaster @feed.webMaster if @feed.webMaster
    @feed.items.each do |item|
      xml.item do
        xml.title item.title
        xml.link item.link
        xml.description item.description
        xml.author item.author if item.author
        xml.comments item.comments if item.comments
        xml.category item.category if item.category
        xml.enclosure item.enclosure if item.enclosure
        xml.pubDate item.publish_date.rfc_822 if item.publish_date
        xml.guid item.guid if item.guid
        xml.source @feed.source if @feed.source
      end
    end
  end
end