require_relative '../lib/job.rb'
require_relative '../lib/scrapper.rb'
require 'nokogiri'
describe Job do
  let(:job_item) { Nokogiri::HTML(open('./lib/test_files/job_item.html')) }

  describe '#initialize' do
    it 'initializes the job object correctly' do
      item_anchor = job_item.css('div.listing-title/h2/a')
      job_title = item_anchor.text
      job_url = item_anchor[0]['href']
      job = Job.new(job_title, job_url)
      expect(job.job_title).to eql(job_title)
      expect(job.job_url).to eql(job_url)
    end
  end

end