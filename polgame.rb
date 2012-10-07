require 'sinatra'
require 'json'
require 'redis'

# The test database is local
db = Redis.new()

get '/game.json' do
  content_type :json
  # Do not touch!
  JSON.parse(db.get('game')).to_json()
end

get '/game' do
  erb :game
end
