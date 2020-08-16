#!/usr/bin/env ruby
require_relative '../lib/scrapper.rb'
require_relative '../lib/job.rb'
require_relative '../lib/about_job.rb'

def scrape(target_url)
  scrapper = Scrapper.new(target_url)
  scrapper
end

scrapper = scrape('http://www.ethiojobs.net')
puts scrapper.scrapped_page