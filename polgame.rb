#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require 'sinatra'
require 'json'
require "httparty"
require 'dalli'
require 'speaker'
require 'quote'

NUMBER_OF_QUOTES = 10

set :cache, Dalli::Client.new
set :quote_controller, QuoteController.new(settings.cache)

get '/game.json' do
  content_type :json

  quote = settings.quote_controller.get_random_quote()

  correct_speaker_id = quote['speaker']['id']

  correct_speaker = Speaker.get_speaker(correct_speaker_id)
  wrong_speaker = Speaker.get_wrong_speaker(correct_speaker_id)
  left_speaker, right_speaker = [correct_speaker, wrong_speaker].shuffle()

  { :quote => quote,
    :left_speaker => left_speaker,
    :right_speaker => right_speaker }.to_json()
end

get '/' do
  erb :game
end
