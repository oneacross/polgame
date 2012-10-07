#!/usr/bin/env ruby

require "redis"

# The test database is local
redis = Redis.new()

obama_img = {
  :url => "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg",
  :height => 299,
  :weight => 220,
  :wapo_api => 1
}

romney_img = {
  :url => "http://reason.com/assets/mc/mriggs/MittRomneyProfilePic.jpg",
  :height => 648,
  :width => 521,
  :wapo_api => 2
}

christie_img = {
  :url => "http://www.state.nj.us/governor/library/photos/gov_christie.jpg",
  :height => 242,
  :width => 170,
  :wapo_api => 3
}

