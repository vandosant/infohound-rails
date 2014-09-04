require 'rails_helper'
require 'vcr'

describe DiggApi do
  it 'gets top news stories' do
    VCR.use_cassette('/news_feeds/digg/top_stories') do
      response = DiggApi.get_response('http://digg.com/rss/top.rss')
      expect(response.code).to eq "200"
      expect(response.body).to_not be_nil
    end
  end

  it 'parses the articles from the response' do
    VCR.use_cassette('/news_feeds/digg/top_stories') do
      response = DiggApi.get_response('http://digg.com/rss/top.rss')
      actual = DiggApi.parse(response.body)
      expect(actual[0][:title]).to eq 'This Is Exactly How Uber Is Sabotaging Lyft'
      expect(actual[0][:description]).to eq 'Uber is arming teams of independent contractors with burner phones and credit cards as part of its sophisticated effort to undermine Lyft and other competitors.'
      expect(actual[0][:link]).to eq 'http://www.theverge.com/2014/8/26/6067663/this-is-ubers-playbook-for-sabotaging-lyft'
      expect(actual[0][:guid]).to eq 'http://on.digg.com/1lurWdy'
      expect(actual[0][:date]).to eq 'Tue, 26 Aug 2014 20:03:59 +0000'
    end
  end
end