#!/usr/bin/env ruby

require 'pry'

require 'ssl_labs'

raise ArgumentError, 'Invalid arguments' unless ARGV.size == 1
ssl_labs = SslLabs.new(ARGV[0])
results = ssl_labs.analyze(:from_cache => true)
puts results.inspect
binding.pry
