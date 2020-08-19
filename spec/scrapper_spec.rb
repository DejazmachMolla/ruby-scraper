require_relative '../lib/scraper.rb'

describe Scraper do
  let(:scraper) { FactoryBot.create_scraper }
  let(:home) { Nokogiri::HTML(open('./lib/test_files/home.html')) }

  describe '#initialize' do
    it 'initializes the scraper object correctly' do
      expect(scraper.target_url).to eql('http://www.ethiojobs.net')
    end
  end

  describe '#scrape' do
    it 'scrapes a webpage specified by the target_url' do
      expect(scraper).to_not be_nil
    end
  end

  describe '#create_scrapped_categories' do
    it 'creates scrapped categories correctly' do
      categories = scraper.create_scrapped_categories
      expect(categories.length).to be >= 2
    end
  end
end
