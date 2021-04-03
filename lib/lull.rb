# frozen_string_literal: true

require 'net/http'
require 'rest-client'

# Helper class for making rest calls
class Lull
  attr_accessor :headers, :meth, :params, :url, :config

  def initialize(headers: {}, meth: 'Get', params: {}, url: 'https://test/', config: {})
    @headers = headers
    @meth    = meth.capitalize.to_sym
    @params  = params
    @url     = url
    @config  = config
    @config['timeout'] = @config['timeout'] ||= 30
  end

  def make_call
    response = RestClient::Request.execute(headers: @headers,
                                           method: @meth, payload: @params,
                                           timeout: @config['timeout'], url: @url, verify_ssl: false)
  rescue SocketError, IOError => e
    puts "#{e.class}: #{e.message}"
    custom_response
  rescue StandardError => e
    e.response
  else
    response
  end

  def cookie
    if @url =~ %r{auth/session}
      response = make_call
      raise 'There was an issue getting a cookie!' unless response.code == 200

      (response.cookies.map { |key, val| "#{key}=#{val}" })[0]
    else
      error_text('cookie', @url.to_s, 'auth/session')
    end
  end

  # use rest-client with retry
  def rest_try(tries = 3)
    tries.times do |i|
      response = make_call
      unless response.nil?
        break response if (200..299).include? response.code
        break response if i > 1
      end
      puts "Failed #{@meth} on #{@url}, retry...#{i + 1}"
      sleep 3 unless i > 1
      return nil if i > 1 # Handles socket errors, etc. where there is no response.
    end
  end

  private

  def custom_response
    net_response = Net::HTTPResponse.new(1.0, 599, 'Error')
    request = RestClient::Request.new(method: :Get, url: 'http://example.com')
    RestClient::Response.create('Can not connect or host not found', net_response, request, nil)
  end

  def error_text(method_name, url, wanted)
    {
      'response' =>
        "ERROR: Wrong url for the #{method_name} method.\n"\
        "Sent: #{url}\n"\
        "Expected: \"#{wanted}\" as part of the url.",
      'status' => 400
    }
  end

  def responder(response)
    {
      'response' => JSON.parse(response.body),
      'status' => response.code.to_i
    }
  end
end
