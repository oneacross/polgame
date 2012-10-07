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

photos = {
  1 => { # Obama
    :url => "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg",
    :height => 299,
    :width => 220
  },
  2 => { # Romney
    :url => "http://reason.com/assets/mc/mriggs/MittRomneyProfilePic.jpg",
    :height => 648,
    :width => 521
  },
  3 => { # Chris Christie
    :url => "http://www.state.nj.us/governor/library/photos/gov_christie.jpg",
    :height => 242,
    :width => 170
  },
  5 => { # Clint Eastwood
    :url => "http://www.newsmax.com/Newsmax/files/1a/1a81ded4-e973-42ee-9079-85da4547dada.jpg",
    :height => 242,
    :width => 170
  },
}

response.parsed_response['objects'].each do |rsp|
  speaker = Speaker.new(rsp)

  if (photos.has_key?(speaker.wapo_id))
    photo = photos[speaker.wapo_id]
    speaker.add_photo(photo[:url], photo[:width], photo[:height])
  end

  # Add speaker to database, if not yet there
  redis.sadd('speakers', speaker.to_json())
end

