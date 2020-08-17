require 'nokogiri'
require './lib/about_job.rb'
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
        job.id_by_ethiojobs = job_listing.css('div.page-header/span.jobs_by/span.num').text
        job.job_description = job_listing.css('div.listingInfo.col-md-12.marg-top-1')
        job.logo_url = Job.create_logo_url(job_listing)
        deadline_unformmated = job_listing.css('div.JobTaskMenu/div/span.post_deadline').first.text.to_s
        job.deadline = deadline_unformmated[8, deadline_unformmated.length]
        job.posted_on = Job.find_posted_on(job_listing)
        job.abouts = create_abouts(detail_page)
      end
      job
    rescue URI::InvalidURIError
      job
    end
  end

  def self.find_posted_on(job_listing)
    posted_on_unformatted = job_listing.at('//div[5]').css('div/script').first.text.to_s
    posted_on_start = posted_on_unformatted.index('"') + 1
    posted_on_end = posted_on_unformatted.index('".split')
    posted_on = posted_on_unformatted[posted_on_start, posted_on_end - posted_on_start].strip
    posted_on = Job.format_date(posted_on)
    posted_on
  end

  def self.format_date(date_format)
    year = date_format[0, 4]
    month = date_format[5, 2]
    date = date_format[8, 2]
    month_names = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    string_format = "#{month_names[month.to_i - 1]} #{date}, #{year}"
    string_format
  end

  def self.create_logo_url(job_listing)
    logo = job_listing.at('//div[8]').css('a/div').to_s
    logo_start_index = logo.index('://').to_i + 3
    if logo_start_index > 24
      logo_end_index = logo.index(')')
      logo_url = logo[logo_start_index, logo_end_index - (logo_start_index + 1)]
    else
      logo_url = 'NO LOGO'
    end
    logo_url
  end

  def create_abouts(detail_page)
    about_jobs = []
    abouts = detail_page.at('//div[4]').css('div/div/div.displayFieldBlock')
    abouts.each do |about|
      key = about.css('div.displaFieldHeader').text
      value = about.css('div.displayField').text.strip
      about_job = AboutJob.new(key, value)
      about_jobs << about_job
    end
    about_jobs
  end
end
