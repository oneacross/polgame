#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require "httparty"
require "redis"
require "pp"
require "speaker"

class WaPoSpeaker
  include HTTParty

  def get_speakers()
    response = self.class.get("http://api.washingtonpost.com/politics/transcripts/api/v1/speaker/?key=#{ENV['WAPO_API_KEY']}")
    return response
  end
end

wapo_speaker = WaPoSpeaker.new()
response =  wapo_speaker.get_speakers()

# The test database is local
redis = Redis.new()

response.parsed_response['objects'].each do |rsp|
  speaker = Speaker.new(rsp)

  # Add speaker to database, if not yet there
  redis.sadd('speakers', speaker.to_json())
end

