require "json"

class Quote

  def initialize(wapo_rsp)
    @id = wapo_rsp['id']
    @text = wapo_rsp['quote']
    @wapo_speaker_id = wapo_rsp['speaker']['id']
    @is_fact_check = true
    @truthiness = wapo_rsp['pinocchio_count']
    @title = wapo_rsp['title']
    @source_url = wapo_rsp['source_url']
  end

  def to_json()
    return {
      :id => @id,
      :text => @text,
      :wapo_speaker_id => @wapo_speaker_id,
      :is_fact_check => @is_fact_check,
      :truthiness => @truthiness,
      :title => @title,
      :source_url => @source_url
    }.to_json
  end

  # API
  def self.get_quote(redis, fact_check_id)
    quotes = redis.smembers('quotes')

    quote = quotes.select do |q|
      JSON.parse(q)['id'] == fact_check_id
    end
  end

end
