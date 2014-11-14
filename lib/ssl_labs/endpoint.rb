require 'ipaddr'
require 'json'

require 'ssl_labs/util'

class SslLabs

  class Endpoint

    ATTRS = [
      :delegation,
      :duration,
      :eta,
      :grade,
      :has_warnings,
      :ip_address,
      :is_exceptional,
      :progress,
      :server_name,
      :status_details,
      :status_details_message,
      :status_message
    ]

    attr_accessor(*ATTRS)

    def self.from_hash(hash)
      endpoint = self.new
      hash.each do |k, v|
        sym = Util.underscore(k).to_sym
        case sym
        when :ip_address
          endpoint.ip_address = IPAddr.new(v)
        when *ATTRS
          endpoint.send("#{sym}=", v)
        else
          raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
        end
      end
      endpoint
    end

  end # Endpoint

end # SslLabs
