
class QuoteController

  def initialize(cache)
    @cache = cache
  end

  def get_quotes()
      response = HTTParty.get("http://api.washingtonpost.com/politics/transcripts/api/v1/statement/?key=#{ENV['WAPO_API_KEY']}&limit=#{NUMBER_OF_QUOTES}")
      return response['objects']
  end

  def shorten(quote)

    # Shorten the quote to 300 chars.
    if quote['text'].length() > 300
      quote['text'] = "#{quote['text'][0, 300]} ..."
    end

    return quote
  end

  def get_random_quote()

    if result = @cache.get('quotes')
      quotes = result
    else
      result = get_quotes()
      @cache.set('quotes', result)
      quotes = result
    end

    quote = quotes.sample()

    return shorten(quote)
  end

end
