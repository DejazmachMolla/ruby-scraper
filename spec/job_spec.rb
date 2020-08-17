require_relative '../lib/job.rb'
require_relative '../lib/scrapper.rb'
require 'nokogiri'
require './spec/factory_bot.rb'

describe Job do
  let(:job_item) { Nokogiri::HTML(open('./lib/test_files/job_item.html')) }
  let(:detail_page) { Nokogiri::HTML(open('./lib/test_files/detail_page.html')) }
  let(:job) { FactoryBot.create_job }
  let(:job_title) { FactoryBot.create_job_title }
  let(:job_url) { FactoryBot.create_job_url }


  describe '#initialize' do
    it 'initializes the job object correctly' do
      expect(job.job_title).to eql(job_title)
      expect(job.job_url).to eql(job_url)
    end
  end

  describe '#create_job_detail' do
    it 'creates the job detail correctly' do
      job.create_job_detail

      job_listing = detail_page.css('div#listingsResults')
      id_by_ethiojobs = job_listing.css('div.page-header/span.jobs_by/span.num').text
      job_description = job_listing.css('div.listingInfo.col-md-12.marg-top-1')
      logo_url = Job.create_logo_url(job_listing)
      deadline_unformmated = job_listing.css('div.JobTaskMenu/div/span.post_deadline').first.text.to_s
      deadline = deadline_unformmated[8, deadline_unformmated.length]
      posted_on = Job.find_posted_on(job_listing)

      expect(job.id_by_ethiojobs).to eql(id_by_ethiojobs)
      expect(job.logo_url).to eql(logo_url)
      expect(job.deadline).to eql(deadline)
      expect(job.posted_on).to eql(posted_on)
    end
  end

end