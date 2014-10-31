require 'json'

class SslLabs

  class Info

    ATTRS = [
      :engine_version,
      :criteria_version,
      :client_max_assessments
    ]

    attr_accessor(*ATTRS)

    # Create an Info from a JSON object.
    def self.from_json(str)
      json = JSON.parse(str)
      info = self.new
      json.each do |k, v|
        case k
        when 'engineVersion'
          info.engine_version = v
        when 'criteriaVersion'
          info.criteria_version = v
        when 'clientMaxAssessments'
          info.client_max_assessments = v.to_i
        else
          raise ArgumentError, "Unknown key #{k.inspect}"
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
