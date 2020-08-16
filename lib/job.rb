require 'nokogiri'

class Job
  attr_accessor :job_title, :job_url, :id_by_ethiojobs, :job_description, :logo_url, :deadline, :posted_on, :abouts

  def initialize(job_title, job_url)
    @job_title = job_title
    @job_url = job_url
  end
end
