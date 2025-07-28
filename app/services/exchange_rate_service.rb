require 'net/http'
require 'json'

class ExchangeRateService
  def self.usd_to_vnd
    uri = URI("https://api.exchangerate.host/latest?base=USD&symbols=VND")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data["rates"]["VND"]
  rescue StandardError => e
    Rails.logger.error("Exchange rate fetch failed: #{e.message}")
    nil
  end
end
