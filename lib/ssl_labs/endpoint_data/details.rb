require 'ssl_labs/endpoint_data/details/cert'
require 'ssl_labs/endpoint_data/details/chain'
require 'ssl_labs/endpoint_data/details/key'
require 'ssl_labs/endpoint_data/details/protocol'
require 'ssl_labs/endpoint_data/details/suite'
require 'ssl_labs/endpoint_data/details/sim'
require 'ssl_labs/util'

class SslLabs

  class EndpointData

    class Details

      ATTRS = [
        :cert,
        :chain,
        :compression_methods,
        :host_start_time,
        :key,
        :non_prefix_delegation,
        :prefix_delegation,
        :protocols,
        :reneg_support,
        :server_signature,
        :session_resumption,
        :suites,
        :vuln_beast,
        :heartbleed,
        :heartbeat,
        :open_ssl_ccs,
        :session_tickets,
        :sni_required,
        :ocsp_stapling,
        :supports_npn,
        :supports_rc4,
        :forward_secrecy,
        :rc4_with_modern,
        :http_status_code,
        :sims
      ]

      attr_accessor(*ATTRS)

      def self.from_hash(hash)
        details = self.new
        hash.each do |k, v|
          sym = Util.underscore(k).to_sym
          case sym
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
            details.suites = v['list'].map { |hash| Suite.from_hash(hash) }
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
