require 'nokogiri'
require 'open-uri'
require 'uri-handler'

class Scraper
  attr_accessor :target_url, :scrapped_page

  def initialize(target_url)
    @target_url = target_url
    @scrapped_page = scrape
  end

  def scrape
    Nokogiri::HTML(URI.open(@target_url))
  end

  def create_scrapped_categories
    scraper = self
    doc = scraper.scrapped_page
    categories = doc.css('div.browse_by.panel.panel-default/ul/a')
    categories
  end
end
