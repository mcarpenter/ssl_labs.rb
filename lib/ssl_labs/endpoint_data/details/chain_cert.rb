require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class ChainCert

        ATTRS = [
          :issuer_label,
          :issuer_subject,
          :issues,
          :label,
          :raw,
          :subject
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          chain_cert = self.new
          hash.each do |k, v|
            case sym = Util.underscore(k).to_sym
            when *ATTRS
              chain_cert.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          chain_cert
        end

      end # ChainCert

    end # Details

  end # EndpointData

end # SslLabs
