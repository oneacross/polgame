require 'sinatra'
require 'json'
require 'redis'

# The test database is local
db = Redis.new()

get '/game.json' do
  content_type :json
  JSON.parse(db.get('game'))
end
