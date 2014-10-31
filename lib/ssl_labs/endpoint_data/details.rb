require 'ssl_labs/endpoint_data/details/cert'
require 'ssl_labs/endpoint_data/details/chain'
require 'ssl_labs/endpoint_data/details/chain_cert'
require 'ssl_labs/endpoint_data/details/key'
require 'ssl_labs/endpoint_data/details/protocol'
require 'ssl_labs/endpoint_data/details/suites'
require 'ssl_labs/endpoint_data/details/sim'
require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      ATTRS = [
        :cert,
        :chain,
        :compression_methods,
        :forward_secrecy,
        :heartbeat,
        :heartbleed,
        :host_start_time,
        :http_forwarding,
        :http_status_code,
        :key,
        :non_prefix_delegation,
        :npn_protocols,
        :ocsp_stapling,
        :open_ssl_ccs,
        :pkp_response_header,
        :prefix_delegation,
        :protocols,
        :rc4_with_modern,
        :reneg_support,
        :server_signature,
        :session_resumption,
        :session_tickets,
        :sims,
        :sni_required,
        :sts_response_header,
        :sts_max_age,
        :sts_sub_domains,
        :suites,
        :supports_npn,
        :supports_rc4,
        :vuln_beast,
      ]

      attr_accessor(*ATTRS)

      def self.from_hash(hash)
        details = self.new
        hash.each do |k, v|
          case sym = Util.underscore(k).to_sym
          when :cert
            details.cert = Cert.from_hash(v)
          when :chain
            details.chain = Chain.from_hash(v)
          when :host_start_time
            details.host_start_time = Time.at(v / 1000.0)
          when :key
            details.key = Key.from_hash(v)
          when :protocols
            details.protocols = v['list'].map { |hash| Protocol.from_hash(hash) }
          when :sims
            details.sims = v['results'].map { |hash| Sim.from_hash(hash) }
          when :suites
            details.suites = Suites.from_hash(v)
          when *ATTRS
            details.send("#{sym}=", v)
          else
            raise ArgumentError, "Unknown key #{k.inspect} (#{sym.inspect})"
          end
        end
        details
      end

    end # Details

  end # EndpointData

end # SslLabs
