require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Sim

        class Client

          ATTRS = [
            :id,
            :name,
            :platform,
            :version,
            :is_reference
          ]
          attr_accessor(*ATTRS)

          def self.from_hash(hash)
            client = self.new
            hash.each do |k, v|
              case sym = Util.underscore(k).to_sym
              when *ATTRS
                client.send("#{sym}=", v)
              else
                raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
              end
            end
            client
          end

        end # Client

      end # Sim

    end # Details

  end # EndpointData

end # SslLabs
