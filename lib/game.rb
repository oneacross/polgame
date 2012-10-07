
class WhoSaidItGame

  def initialize(quote, left_speaker, right_speaker)
    @game = {
      :quote => quote,
      :left_speaker => left_speaker,
      :right_speaker => right_speaker
    }
  end

  def to_json()
    @game.to_json()
  end
end

