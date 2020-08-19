require_relative '../lib/job.rb'
require_relative '../lib/scraper.rb'
require 'nokogiri'
require_relative './factory_bot.rb'

describe Job do
  let(:job_item) { Nokogiri::HTML(open('./spec/test_files/job_item.html')) }
  let(:detail_page) { Nokogiri::HTML(open('./spec/test_files/detail_page.html')) }
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
      deadline_unformmated = job_listing.css('div.JobTaskMenu/div/span.post_deadline').first.text.to_s
      deadline = deadline_unformmated[8, deadline_unformmated.length]

      expect(job.id_by_ethiojobs).to eql(id_by_ethiojobs)
      expect(job.deadline).to eql(deadline)
    end
  end

  describe '#create_abouts' do
    it 'creates the abouts attribute of a job object correctly' do
      abouts = job.create_abouts(detail_page)
      expect(abouts.length).to eql(3)
      about_job = abouts[0]
      expect(about_job.about_key).to eql('Category:')
      expect(about_job.about_value).to eql('Accounting and Finance')
    end
  end
end
