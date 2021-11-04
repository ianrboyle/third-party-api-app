class StocksController < ApplicationController

  def create
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://yfapi.net/v8/finance/spark?symbols=AAPL")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-api-key"] = ''

    response = http.request(request)
    stock = response.read_body
    render json: stock.as_json
  end
end
