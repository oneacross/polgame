#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require "redis"
require "pp"
require "quote"
require "speaker"
require "game"

# The test database is local
redis = Redis.new()

quote = Quote.get_quote(redis, fact_check_id=235)
speaker = Speaker.get_speaker(redis, quote['wapo_speaker_id'])
wrong_speaker = Speaker.get_wrong_speaker(redis, quote['wapo_speaker_id'])

game = WhoSaidItGame.new(quote, speaker, wrong_speaker)

redis.set('game', game.to_json())

