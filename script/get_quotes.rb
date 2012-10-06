#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require "httparty"
require "redis"
require "pp"
require "quote"

class WaPoQuoteApi
  include HTTParty

  def get_quotes(speaker_id, count=10)
    speaker = CGI.escape("{\"id\": #{speaker_id}}")
    response = self.class.get("http://api.washingtonpost.com/politics/transcripts/api/v1/fact-check/?key=#{ENV['WAPO_API_KEY']}&speaker=#{speaker}&limit=5")
  end
end

wapo_quotes = WaPoQuoteApi.new()
quotes = wapo_quotes.get_quotes(1) 

# The test database is local
redis = Redis.new()

quotes.parsed_response['objects'].each do |rsp|

  quote = Quote.new(rsp)

  # Add quote to database, if not yet there
  redis.sadd('quotes', quote.to_json())
end

