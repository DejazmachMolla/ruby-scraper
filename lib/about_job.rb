class AboutJob
  attr_accessor :about_key, :about_value

  def initialize(about_key, about_value)
    @about_key = about_key
    @about_value = about_value
  end
end
