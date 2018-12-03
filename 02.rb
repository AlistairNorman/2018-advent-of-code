#!/usr/bin/env ruby
require 'pry'

data = File.read("data/02.txt").lines.map(&:strip)

# part one
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

# part two
data.each do |datum1|
  datum1 = datum1.split('')

  data.each do |datum2|
    uncommon = 0
    datum2 = datum2.split('')
     
    i = 0
    while i < 26 do
      if datum1[i] != datum2[i]
        uncommon += 1
      end
      i += 1
    end

    if uncommon == 1
      puts datum1.join
    end
  end
end
