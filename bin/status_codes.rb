#!/usr/bin/env ruby

require 'ssl_labs'

ssl_labs = SslLabs.new
status_codes = ssl_labs.status_codes
max_len = status_codes.keys.map(&:length).max
status_codes.each do |k, v|
  puts "%-#{max_len}s %s" % [k, v]
end
