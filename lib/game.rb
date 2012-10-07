
class WhoSaidItGame

  def initialize(quote)
    @quote = quote
  end

  def to_json()
    @quote.to_json()
  end
end

