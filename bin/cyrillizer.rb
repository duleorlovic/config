#!/usr/bin/env ruby
begin
  require 'cyrillizer'
rescue LoadError
  puts 'Please install cyrillizer gem'
  puts 'gem install cyrillizer'
  exit
end

Cyrillizer.language = :serbian
target = ARGV[0] || 'to_cyr'

text = STDIN.gets

print case target
      when 'to_cyr'
        text.to_cyr
      else
        text.to_lat
      end
