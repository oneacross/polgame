class Speaker

    attr_accessor :wapo_id

    def initialize(wapo_rsp)
      @wapo_id = wapo_rsp['id']
      @first_name = wapo_rsp['first_name']
      @last_name = wapo_rsp['last_name']
      @party = wapo_rsp['party']
      @photo = {}
    end

    def add_photo(url, width, height)
      @photo = {
        :url => url,
        :width => width,
        :height => height
      }
    end

    def to_json()
      return {
        :wapo_api => @wapo_id,
        :first_name => @first_name,
        :last_name => @last_name,
        :party => @party
      }.merge(@photo).to_json
    end

    # API
    def self.get_speaker(db, speaker_id)
      speakers = db.smembers('speakers')

      speaker = speakers.select do |spkr|
        JSON.parse(spkr)['wapo_api'] == speaker_id
      end.first

      JSON.parse(speaker)
    end

    def self.get_wrong_speaker(db, speaker_id)
      speakers = db.smembers('speakers')

      speaker = speakers.select do |spkr|
        JSON.parse(spkr)['wapo_api'] != speaker_id
      end.sample

      JSON.parse(speaker)
    end
end
