require 'active_support/inflector'

class SslLabs

  # Utility methods.
  module Util

    # Camelizes a snake case method or argument name.
    # For example "get_status_codes" -> GetStatusCodes'.
    def self.camelize(snake)
      snake.to_s.camelize(:lower)
    end

    # Snake cases a method or argument name.
    # For example "getStatusCodes" -> 'get_status_codes'.
    def self.underscore(camel)
      camel.to_s.underscore
    end

  end # Util

end # SslLabs
