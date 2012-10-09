#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require 'sinatra'
require 'json'
require 'redis'
require "httparty"
require 'speaker'

NUMBER_OF_QUOTES = 10

cached_results = []

get '/game.json' do
  content_type :json

  if (cached_results.empty?)
    quotes = HTTParty.get("http://api.washingtonpost.com/politics/transcripts/api/v1/statement/?key=#{ENV['WAPO_API_KEY']}&limit=#{NUMBER_OF_QUOTES}")

    # Randomly pick one
    game_quote = quotes['objects'].sample()

    cached_results = quotes['objects']
  else
    game_quote = cached_results.sample()
  end

  # Shorten the quote to 300 chars.
  if game_quote['text'].length() > 300
    game_quote['text'] = "#{game_quote['text'][0, 300]} ..."
  end

  correct_speaker = Speaker.get_speaker(game_quote['speaker']['id'])
  correct_speaker['correct'] = true
  wrong_speaker = Speaker.get_wrong_speaker(game_quote['speaker']['id'])
  left_speaker, right_speaker = [correct_speaker, wrong_speaker].shuffle()

  { :quote => game_quote,
    :left_speaker => left_speaker,
    :right_speaker => right_speaker }.to_json()
end

get '/' do
  erb :game
end
