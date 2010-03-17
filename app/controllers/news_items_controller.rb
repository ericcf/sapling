class NewsItemsController < ApplicationController

  def show
    @news_item = NewsItem.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @news_item.to_xml }
    end
  end

  def atom_feed

  end

  def rss_feed
    @feed = RSSFeed.new(:title => 'Northwestern Radiology',
                        :link => root_url,
                        :description => 'NU Rad News')
    render 'news_items/rss_feed.xml.builder'
  end
end
