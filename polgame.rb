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

# Hack!
speakers_db = [
  {"wapo_api" => 3,"first_name" => "Chris","last_name"=>"Christie","party"=>"Republican","url"=>"http://www.state.nj.us/governor/library/photos/gov_christie.jpg","width"=>170,"height"=>242},
  {"wapo_api" => 5,"first_name" => "Clint","last_name"=>"Eastwood","party"=>"Republican","url"=>"http://www.newsmax.com/Newsmax/files/1a/1a81ded4-e973-42ee-9079-85da4547dada.jpg","width"=>170,"height"=>242},
  {"wapo_api" => 7,"first_name" => "Jim","last_name"=>"Lehrer","party"=>"","url"=>"http://www.pbs.org/newshour/aboutus/images/photo_bio_lehrer.jpg","width"=>170,"height"=>242},
  {"wapo_api" => 2,"first_name" => "Mitt","last_name"=>"Romney","party"=>"Republican","url"=>"http://reason.com/assets/mc/mriggs/MittRomneyProfilePic.jpg","width"=>521,"height"=>648},
  {"wapo_api" => 6,"first_name" => "Bill","last_name"=>"Clinton","party"=>"Democrat","url"=>"http://www.florencedailynews.com/wp-content/uploads/2012/09/bill-clinton-picture.jpg","width"=>170,"height"=>242},
  {"wapo_api" => 1,"first_name" => "Barack","last_name"=>"Obama","party"=>"Democrat","url"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg","width"=>220,"height"=>299},
  {"wapo_api" => 4,"first_name" => "Paul","last_name"=>"Ryan","party"=>"Republican","url"=>"http://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Paul_Ryan_official_portrait.jpg/220px-Paul_Ryan_official_portrait.jpg","width"=>170,"height"=>242}
]

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

  correct_speaker = Speaker.get_speaker(speakers_db, game_quote['speaker']['id'])
  correct_speaker['correct'] = true
  wrong_speaker = Speaker.get_wrong_speaker(speakers_db, game_quote['speaker']['id'])

  speakers = [correct_speaker, wrong_speaker].shuffle()
  left_speaker = speakers[0]
  right_speaker = speakers[1]

  game = WhoSaidItGame.new(game_quote, left_speaker, right_speaker)

  game.to_json()
end

get '/' do
  erb :game
end
