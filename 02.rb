#!/usr/bin/env ruby
require 'pry'

data = File.read("data/02.txt").lines.map(&:strip)

doubles = 0
triples = 0

data.each do |datum|
  datum = datum.split('')
  seen = Hash.new

  datum.each do |char|
    seen[char] ||= 0
    seen[char] += 1
  end

  if seen.find{|key,value| value == 3}
    triples += 1
  end

  if seen.find{|key,value| value == 2}
    doubles += 1
  end
end

puts doubles * triples
