require_relative '../lib/scrapper.rb'

describe Scrapper do
  let(:scrapper) { FactoryBot.create_scrapper }
  let(:home) { Nokogiri::HTML(open('./lib/test_files/home.html')) }
  
  describe '#initialize' do
    it 'initializes the scrapper object correctly' do
      expect(scrapper.target_url).to eql('http://www.ethiojobs.net')
    end
  end
end
