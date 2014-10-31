require 'ssl_labs/endpoint'
require 'ssl_labs/util'

class SslLabs

  class Host

    ATTRS = [
      :criteria_version,
      :delegation,
      :duration,
      :endpoints,
      :engine_version,
      :eta,
      :grade,
      :has_warnings,
      :host,
      :is_exceptional,
      :is_public,
      :port,
      :progress,
      :protocol,
      :start_time,
      :status,
      :status_message,
      :test_time
    ]

    attr_accessor(*ATTRS)

    def initialize
      @endpoints = []
    end

    def self.from_json(str)
      json = JSON.parse(str)
      host = self.new
      json.each do |k, v|
        sym = Util.underscore(k).to_sym
        if ATTRS.include?(sym)
          case sym
          when :start_time
            host.start_time = Time.at(v / 1000.0)
          when :endpoints
            host.endpoints += v.map { |ep| Endpoint.from_hash(ep) }
          else
            host.send("#{sym}=", v)
          end
        else
          raise ArgumentError, "Unknown JSON key #{k.inspect} (#{sym.inspect})"
        end
      end
      host
    end

  end # Host

end # SslLabs
