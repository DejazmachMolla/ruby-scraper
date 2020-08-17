require_relative '../lib/job.rb'
require 'nokogiri'

class FactoryBot
  def self.create_job_item_anchor
    job_item = Nokogiri::HTML(open('./lib/test_files/job_item.html'))
    item_anchor = job_item.css('div.listing-title/h2/a')
  end

  def self.create_job
    item_anchor = FactoryBot.create_job_item_anchor
    job_title = item_anchor.text
    job_url = item_anchor[0]['href']
    Job.new(job_title, job_url)
  end

  def self.create_job_title
    item_anchor = FactoryBot.create_job_item_anchor
    item_anchor.text
  end

  def self.create_job_url
    item_anchor = FactoryBot.create_job_item_anchor
    item_anchor[0]['href']
  end
  
end