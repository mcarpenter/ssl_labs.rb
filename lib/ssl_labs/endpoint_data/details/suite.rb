require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Suite

        ATTRS = [
          :cipher_strength,
          :dh_g,
          :dh_p,
          :dh_strength,
          :dh_ys,
          :ecdh_bits,
          :ecdh_strength,
          :id,
          :name,
          :q
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          suite = self.new
          hash.each do |k, v|
            case sym = Util.underscore(k).to_sym
            when *ATTRS
              suite.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          suite
        end

      end # Suite

    end # Details

  end # EndpointData

end # SslLabs
