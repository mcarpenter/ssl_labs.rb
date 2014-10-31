require 'ssl_labs/endpoint_data/details/sim/client'
require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Sim

        ATTRS = [
          :client,
          :error_code,
          :attempts,
          :protocol_id,
          :suite_id
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          sim = self.new
          hash.each do |k, v|
            sym = Util.underscore(k).to_sym
            if sym == :client
              sim.client = Sim::Client.from_hash(v)
            elsif ATTRS.include?(sym)
              sim.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          sim
        end

      end # Sim

    end # Details

  end # EndpointData

end # SslLabs
