require 'ssl_labs/endpoint_data/details/cert'

class SslLabs

  class EndpointData

    class Details

      class Chain

        ATTRS = [
          :certs,
          :issues
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          chain = self.new
          hash.each do |k, v|
            case sym = Util.underscore(k).to_sym
            when :certs
              chain.certs = v.map { |cert| Cert.from_hash(cert) }
            when *ATTRS
              chain.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          chain
        end

      end # Chain

    end # Details

  end # EndpointData

end # SslLabs
