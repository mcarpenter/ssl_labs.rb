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

    def self.from_hash(hash)
      endpoint = self.new
      hash.each do |k, v|
        sym = Util.underscore(k).to_sym
        if ATTRS.include?(sym)
          case sym
          when :ip_address
            endpoint.ip_address = IPAddr.new(v)
          when :details
            endpoint.details = EndpointData::Details.from_hash(v)
          else
            endpoint.send("#{sym}=", v)
          end
        else
          raise ArgumentError, "Unknown key #{k.inspect} (#{sym})"
        end
      end
      endpoint
    end

  end # EndpointData

end # SslLabs
