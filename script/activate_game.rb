#!/usr/bin/env ruby

$LOAD_PATH << "lib"

require "redis"
require "pp"
require "quote"
require "game"

# The test database is local
redis = Redis.new()

quote = Quote.get_quote(redis, fact_check_id=235)

game = WhoSaidItGame.new(quote)

redis.set('game', game.to_json())

