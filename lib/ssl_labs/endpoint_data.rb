require 'ipaddr'
require 'json'

require 'ssl_labs/util'
require 'ssl_labs/endpoint_data/details'

class SslLabs

  class EndpointData

    ATTRS = [
      :delegation,
      :details,
      :duration,
      :eta,
      :grade,
      :has_warnings,
      :ip_address,
      :is_exceptional,
      :progress,
      :server_name,
      :status_message
    ]

    attr_accessor(*ATTRS)

    def self.from_json(str)
      json = JSON.parse(str)
      endpoint = self.new
      json.each do |k, v|
        case sym = Util.underscore(k).to_sym
        when :ip_address
          endpoint.ip_address = IPAddr.new(v)
        when :details
          endpoint.details = EndpointData::Details.from_hash(v)
        when *ATTRS
          endpoint.send("#{sym}=", v)
        else
          raise ArgumentError, "Unknown key #{k.inspect} (#{sym})"
        end
      end
      endpoint
    end

  end # EndpointData

end # SslLabs
