require_relative '../lib/scrapper.rb'

describe Scrapper do
  let(:scrapper) { FactoryBot.create_scrapper }
  let(:home) { Nokogiri::HTML(open('./lib/test_files/home.html')) }
  
  describe '#initialize' do
    it 'initializes the scrapper object correctly' do
      expect(scrapper.target_url).to eql('http://www.ethiojobs.net')
    end
  end

  describe '#scrape' do
    it 'scrapes a webpage specified by the target_url' do
      expect(scrapper).to_not be_nil
    end
  end

  describe '#create_scrapped_categories' do
    it 'creates scrapped categories correctly' do
      categories = scrapper.create_scrapped_categories
      expect(categories.length).to be >= 41
    end
  end
end
