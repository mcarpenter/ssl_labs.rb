require 'json'

require 'ssl_labs/util'

class SslLabs

  class Info

    ATTRS = [
      :engine_version,
      :criteria_version,
      :client_max_assessments,
      :notice
    ]

    attr_accessor(*ATTRS)

    # Create an Info from a JSON object.
    def self.from_json(str)
      json = JSON.parse(str)
      info = self.new
      json.each do |k, v|
        case sym = Util.underscore(k).to_sym
        when :client_max_assessments
          info.client_max_assessments = v.to_i
        when *ATTRS
          info.send("#{sym}=", v)
        else
          raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
        end
        info
      end
    end

    # Convert an Info to a Hash.
    def to_hash
      Hash[*ATTRS.map { |attr| [attr, self.send(attr)] }]
    end

  end # Info

end # SslLabs
