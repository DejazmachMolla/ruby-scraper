require 'nokogiri'

class Job
  attr_accessor :job_title, :job_url, :id_by_ethiojobs, :job_description, :logo_url, :deadline, :posted_on, :abouts

  def initialize(job_title, job_url)
    @job_title = job_title
    @job_url = job_url
  end

  def create_job_detail
    job = self
    begin
      scrapper = Scrapper.new(job.job_url)
      detail_page = scrapper.scrapped_page
      job_listing = detail_page.css('div#listingsResults')
      unless job_listing.nil?
        job.id_by_ethiojobs = job_listing.at('//div[4]').css('div.page-header/span.jobs_by/span.num').text
        job.job_description = job_listing.css('div.listingInfo.col-md-12.marg-top-1')
        job.logo_url = Job.create_logo_url(job_listing)
        deadline_unformmated = job_listing.css('div.JobTaskMenu/div/span.post_deadline').first.text.to_s
        job.deadline = deadline_unformmated[8, deadline_unformmated.length]
        job.posted_on = find_posted_on(job_listing)
        job.abouts = create_abouts(detail_page)
      end
      job
    rescue URI::InvalidURIError
      job
    end
  end
  
end
