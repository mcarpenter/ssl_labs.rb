require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Protocol

        ATTRS = [
          :id,
          :name,
          :version
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          protocol = self.new
          hash.each do |k, v|
            sym = Util.underscore(k).to_sym
            if ATTRS.include?(sym)
              protocol.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          protocol
        end

      end # Protocol

    end # Details

  end # EndpointData

end # SslLabs
