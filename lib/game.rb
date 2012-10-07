
class WhoSaidItGame

  def initialize(quote, speaker, wrong_speaker)
    @game = {
      #:quote_id => quote['id']
      :quote => quote,
      :speaker => speaker,
      :wrong_speaker => wrong_speaker
    }
  end

  def to_json()
    @game.to_json()
  end
end

