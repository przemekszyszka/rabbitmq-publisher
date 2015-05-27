require 'net/http'
require 'uri'
require 'json'

class OpenExchangeRatesFetcher
  def fetch_currencies
    last_currency = Currency.last
    return last_currency if last_currency.present? && last_currency.updated_at + 1.hour < Time.now
    url = URI.parse("http://openexchangerates.org/api/latest.json?app_id=#{ENV["OPEN_EXCHANGE_API_KEY"]}")
    response = Net::HTTP.get_response(url)
    create_currency(response.body)
  end

  private

  def create_currency(body)
    rates = JSON.parse(body)['rates']
    Currency.create!(rates: rates)
  end
end
