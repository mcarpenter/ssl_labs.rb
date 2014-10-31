require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      class Cert

        ATTRS = [
          :alt_names,
          :common_names,
          :crl_uris,
          :issuer_label,
          :issuer_subject,
          :issues,
          :not_after,
          :not_before,
          :ocsp_uris,
          :revocation_info,
          :revocation_status,
          :scg,
          :sig_alg,
          :subject,
          :validation_type
        ]

        attr_accessor(*ATTRS)

        def self.from_hash(hash)
          cert = self.new
          hash.each do |k, v|
            case sym = Util.underscore(k).to_sym
            when :crl_ur_is
              cert.crl_uris = v
            when :not_after
              cert.not_after = Time.at(v / 1000.0)
            when :not_before
              cert.not_before = Time.at(v / 1000.0)
            when :ocsp_ur_is
              cert.ocsp_uris = v
            when *ATTRS
              cert.send("#{sym}=", v)
            else
              raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
            end
          end
          cert
        end

      end # Cert

    end # Details

  end # EndpointData

end # SslLabs
