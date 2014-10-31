require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Suite

        ATTRS = [
          :id,
          :name,
          :cipher_strength,
          :dh_strength,
          :dh_p,
          :dh_g,
          :dh_ys,
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
