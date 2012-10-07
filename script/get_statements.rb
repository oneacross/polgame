#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require "httparty"
require "redis"
require 'json'
require "pp"
require "quote"
require 'speaker'
require 'game'

class WaPoQuoteApi
  include HTTParty

  def get_50_quotes()
    response = self.class.get("http://api.washingtonpost.com/politics/transcripts/api/v1/statement/?key=#{ENV['WAPO_API_KEY']}&limit=50")
  end
end

wapo_quotes = WaPoQuoteApi.new()
quotes = wapo_quotes.get_50_quotes()
game_quote = quotes['objects'].sample().to_json()

pp game_quote

