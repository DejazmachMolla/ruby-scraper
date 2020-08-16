require 'nokogiri'
require 'open-uri'
require 'uri-handler'

class Scrapper
  attr_accessor :target_url, :scrapped_page

  def initialize(target_url)
    @target_url = target_url
    @scrapped_page = scrape
  end

  def scrape
    Nokogiri::HTML(URI.open(@target_url))
  end
end
