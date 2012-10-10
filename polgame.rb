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
set :speaker_controller, SpeakerController.new()

get '/game.json' do
  content_type :json

  quote = settings.quote_controller.get_random_quote()
  speakers = settings.speaker_controller.get_speaker_pair(quote)

  left_speaker, right_speaker = speakers

  { :quote => quote,
    :left_speaker => left_speaker,
    :right_speaker => right_speaker }.to_json()
end

get '/' do
  erb :game
end
