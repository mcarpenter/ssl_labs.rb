require 'ssl_labs/util'

class SslLabs

  module Api

    # Base URI for the API.
    LOCATION = 'https://api.dev.ssllabs.com/api/fa78d5a4'

    # Array of known methods.
    METHODS = [
      :analyze,
      :get_endpoint_data,
      :get_status_codes,
      :info
    ]

    # Return the API URL for the given method and arguments.
    def self.url(method, args={})
      raise ArgumentError, "Unknown method #{method.inspect}" unless METHODS.include?(method)
      camelized_method = Util::camelize(method)
      query = if args.empty?
                ''
              else
                '?' << args.map do |k, v|
                  "#{Util.camelize(k)}=#{v}"
                end.join('&') # XXX escaping
              end
      "#{LOCATION}/#{camelized_method}#{query}"
    end

  end # Api

end # SslLabs
