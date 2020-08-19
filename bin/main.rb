#!/usr/bin/env ruby
require_relative '../lib/scraper.rb'
require_relative '../lib/job.rb'
require_relative '../lib/about_job.rb'
require_relative '../lib/display.rb'

private
def url_generator(page, category_name)
  if page == 'home'
    'http://www.ethiojobs.net'
  else
    "http://www.ethiojobs.net/browse-by-category/#{category_name.to_uri}/?action=search&
    page=1&listings_per_page=100&view=list"
  end
end

private
def find_by_category(category_name)
  single_category_jobs = find_single_category_jobs(category_name)
  if single_category_jobs.length.zero?
    Display.display_no_job_found
  else
    list_single_category_jobs(single_category_jobs)
  end
end

private
def list_single_category_jobs(single_category_jobs)
  single_category_jobs.each do |job_item|
    item_anchor = job_item.css('div.listing-title/h2/a')
    job_title = item_anchor.text
    job_url = item_anchor[0]['href']
    Display.display_job_title(job_title)
    job = Job.new(job_title, job_url)
    job = job.create_job_detail
    Display.display_job(job)
  end
end

private
def loop_categories(categories)
  categories.each do |category|
    category_name = create_category_name(category)
    Display.display_category_name(category_name)
    find_by_category(category_name)
  end
end

private
def find_single_category_jobs(category_name)
  search_url = url_generator('category_list', category_name)
  page = scrape(search_url).scrapped_page
  items = page.css('div.listing-section')
  items
end

private
def create_category_name(category)
  text_content = category['title']
  suffix_index = text_content.index(' Jobs in Ethiopia')
  category_name = text_content[0, suffix_index]
  category_name
end

private
def scrape(target_url)
  scraper = Scraper.new(target_url)
  scraper
end

scraper = scrape(url_generator('home', nil))
categories = scraper.create_scrapped_categories
Display.display_no_of_categories(categories.length)
loop_categories(categories)
