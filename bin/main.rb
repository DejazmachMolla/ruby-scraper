#!/usr/bin/env ruby
require_relative '../lib/scrapper.rb'
require_relative '../lib/job.rb'
require_relative '../lib/about_job.rb'
require_relative '../lib/display.rb'

def url_generator(page, category_name)
  if page == 'home'
    'http://www.ethiojobs.net'
  else
    "http://www.ethiojobs.net/browse-by-category/#{category_name.to_uri}/?action=search&
    page=1&listings_per_page=100&view=list"
  end
end

def scrape(target_url)
  scrapper = Scrapper.new(target_url)
  scrapper
end

scrapper = scrape(url_generator('home', nil))
categories = scrapper.create_scraped_categories
Display.display_no_of_categories(categories.length)