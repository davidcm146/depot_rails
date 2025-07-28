module ExchangeRateHelper
  def localized_currency(amount_usd)
    case I18n.locale.to_s
    when "vi"
      vnd_rate = ExchangeRateService.usd_to_vnd || 25000
      amount_vnd = amount_usd * vnd_rate
      number_to_currency(amount_vnd)
    else
      number_to_currency(amount_usd)
    end
  end
end
