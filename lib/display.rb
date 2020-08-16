require 'colorize'

module Display
  def self.display_no_of_categories(num)
    info = "#{num} CATEGORIES FOUND"
    puts info.green
  end
end