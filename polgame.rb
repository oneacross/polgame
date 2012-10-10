#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require 'sinatra'
require 'json'
require "httparty"
require 'speaker'
require 'dalli'

NUMBER_OF_QUOTES = 10

set :cache, Dalli::Client.new

def get_quotes()
    response = HTTParty.get("http://api.washingtonpost.com/politics/transcripts/api/v1/statement/?key=#{ENV['WAPO_API_KEY']}&limit=#{NUMBER_OF_QUOTES}")
    return response['objects']
end

def cached(cache_key)

  if result = settings.cache.get(cache_key)
    return result
  else
    result = yield
    settings.cache.set(cache_key, result)

    return result
  end
end

get '/game.json' do
  content_type :json

  quotes = cached('quotes') do
    get_quotes()
  end

  # Randomly pick one
  game_quote = quotes.sample()

  # Shorten the quote to 300 chars.
  if game_quote['text'].length() > 300
    game_quote['text'] = "#{game_quote['text'][0, 300]} ..."
  end

  correct_speaker_id = game_quote['speaker']['id']

  correct_speaker = Speaker.get_speaker(correct_speaker_id)
  wrong_speaker = Speaker.get_wrong_speaker(correct_speaker_id)
  left_speaker, right_speaker = [correct_speaker, wrong_speaker].shuffle()

  { :quote => game_quote,
    :left_speaker => left_speaker,
    :right_speaker => right_speaker }.to_json()
end

get '/' do
  erb :game
end
