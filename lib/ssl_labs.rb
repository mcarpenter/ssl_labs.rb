require 'mechanize'
require 'uri'

require 'ssl_labs/api'
require 'ssl_labs/endpoint_data'
require 'ssl_labs/host'
require 'ssl_labs/info'

class SslLabs

  # Gem version.
  VERSION = '0.0.1'

  # User agent for client.
  USER_AGENT = "ssl_labs.rb #{VERSION}"

  # Seconds to delay between analysis polls.
  POLL_SLEEP = 10

  attr_accessor :uri
  attr_accessor :agent

  def initialize(uri=nil)
    @uri = URI(uri) unless uri.nil?
    @agent = Mechanize.new
    @agent.user_agent = USER_AGENT
  end

  # Run the analyze method and return immediately with Host response
  # from the server. Do not wait for analysis to complete.
  def analyze(opts={})
    defaults = {:host => uri.host}
    opts_a = opts.flat_map do |k, v|
      case k
      when :publish, :clear_cache, :from_cache
        [k, v ? 'on' : 'off']
      when :all
        if v == true
          [k, 'on']
        elsif v == :done
          [k, v]
        else
          raise ArgumentError, "Invalid value for option #{k.inspect}"
        end
      else
        raise ArgumentError, "Invalid option #{k.inspect}"
      end
    end
    json = invoke(:analyze, defaults.merge(Hash[*opts_a]))
    Host.from_json(json)
  end

  # Clears the cache and blocks until analyze returns results.
  # Returns an Array of SslLabs::EndpointData.
  def analyze!
    host = analyze(:clear_cache => true)
    loop do
      sleep(POLL_SLEEP)
      host = analyze
      break if %w{READY ERROR}.include?(host.status)
    end
    host.endpoints.map { |ep| endpoint_data(ep) }
  end

  # Return EndpointData from an EndPoint.
  def endpoint_data(ep, from_cache=false)
    body = invoke(:get_endpoint_data,
                  :host => uri.host,
                  :s => ep.ip_address,
                  :from_cache => from_cache ? 'on' : 'off')
    EndpointData.from_json(body)
  end

  # Return an Info object.
  def info
    body = invoke(:info)
    Info.from_json(body)
  end

  # Return a Hash of status codes (String => String).
  def status_codes
    body = invoke(:get_status_codes)
    json = JSON.parse(body)
    json['statusDetails']
  end

  # Return the Mechanize::Page body for the given method and arguments.
  def invoke(method, args={})
    url = Api.url(method, args)
    @agent.get(url).body
  end

end # SslLabs
