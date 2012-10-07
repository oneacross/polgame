#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require 'sinatra'
require 'json'
require 'redis'
require "httparty"
require 'quote'
require 'speaker'
require 'game'

class WaPoQuoteApi
  include HTTParty

  def get_50_quotes()
    response = self.class.get("http://api.washingtonpost.com/politics/transcripts/api/v1/statement/?key=#{ENV['WAPO_API_KEY']}&limit=20")
  end
end

# The test database is local
db = Redis.new()

get '/game.json' do
  content_type :json

  # Get the last 50 quotes from the API
  wapo_quotes = WaPoQuoteApi.new()
  quotes = wapo_quotes.get_50_quotes() 

  # Randomly pick one
  game_quote = quotes['objects'].sample()

  # Shorten the quote to 300 chars.
  if game_quote['text'].length() > 300
    game_quote['text'] = "#{game_quote['text'][0, 300]} ..."
  end

  speaker = Speaker.get_speaker(db, game_quote['speaker']['id'])
  wrong_speaker = Speaker.get_wrong_speaker(db, game_quote['speaker']['id'])

  game = WhoSaidItGame.new(game_quote, speaker, wrong_speaker)

  game.to_json()
end

get '/game' do
  erb :game
end
