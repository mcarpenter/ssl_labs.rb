#!/usr/bin/env ruby

require 'ssl_labs'

ssl_labs = SslLabs.new
info = ssl_labs.info.to_hash
max_len = info.keys.map(&:length).max
info.each do |k, v|
  puts "%-#{max_len}s %s" % [k, v]
end
