#!/usr/bin/env ruby

require "redis"

# The test database is local
redis = Redis.new()

obama_img = {
  :wapo_api => 1
}

romney_img = {
  :wapo_api => 2
}

christie_img = {
  :wapo_api => 3
}

