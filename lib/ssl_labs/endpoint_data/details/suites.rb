require 'ssl_labs/endpoint_data/details/suite'
require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      # Implements a list of ciphersuites. The list is directly accessible
      # via #list but otherwise Array instance methods called on Suites
      # are delegated to the list automatically.
      class Suites

        ATTRS = [
          :list,
          :preference
        ]

        attr_accessor(*ATTRS)

        def initialize
          @list = []
        end

        def method_missing(method, *args, &blk)
          [].respond_to?(method) ? @list.send(method, *args, &blk) : super
        end

        def respond_to?(method)
          super || [].respond_to?(method)
        end

        def self.from_hash(hash)
          suites = self.new
          hash.each do |k, v|
            case sym = Util.underscore(k).to_sym
            when :list
              suites.list = v.map { |hash| Suite.from_hash(hash) }
            when *ATTRS
              suites.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          suites
        end

      end # Suites

    end # Details

  end # EndpointData

end # SslLabs
