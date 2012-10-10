
class QuoteController

  def initialize(cache)
    @cache = cache
  end

  def get_quotes()
      response = HTTParty.get("http://api.washingtonpost.com/politics/transcripts/api/v1/statement/?key=#{ENV['WAPO_API_KEY']}&limit=#{NUMBER_OF_QUOTES}")
      return response['objects']
  end

  def get_random_quote()

    if result = @cache.get('quotes')
      puts "Grabbed from cache!"
      quotes = result
    else
      puts "Was not in cache"
      result = get_quotes()
      @cache.set('quotes', result)
    end

    quotes.sample()
  end

end
