require 'colorize'

module Display
  def self.horizontal_line(sym, width)
    sym * width
  end

  def self.left_indent(str)
    left_indent = (130 - str.length) / 2
    left_indent_str = ''
    left_indent_str = ' ' * left_indent if left_indent.positive?
    left_indent_str
  end

  def self.display_no_of_categories(num)
    info = "#{num} CATEGORIES FOUND"
    puts info.green
  end

  def self.display_category_name(category_name)
    left_indent_str = left_indent(category_name)
    puts "\n"
    puts horizontal_line('*', 130).cyan
    puts "#{left_indent_str}#{category_name.upcase} JOBS"
    puts horizontal_line('*', 130).cyan
    puts
  end

  def self.display_no_job_found
    puts
    no_jobs = 'NO JOBS FOUND IN THIS CATEGORY!'
    puts no_jobs.red
  end

  def self.display_job_title(job_title)
    job_title = job_title.to_s
    left_indent_str = left_indent(job_title)
    puts "#{left_indent_str}#{horizontal_line('=', job_title.length + 6).green}"
    puts "#{left_indent_str}   #{job_title.upcase}"
    puts "#{left_indent_str}#{horizontal_line('=', job_title.length + 6).green}"
  end
end