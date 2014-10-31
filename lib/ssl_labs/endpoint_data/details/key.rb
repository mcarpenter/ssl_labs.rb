require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Key

        ATTRS = [
          :size,
          :strength,
          :alg,
          :debian_flaw,
          :q
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          key = self.new
          hash.each do |k, v|
            case sym = Util.underscore(k).to_sym
            when *ATTRS
              key.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          key
        end

      end # Key

    end # Details

  end # EndpointData

end # SslLabs
