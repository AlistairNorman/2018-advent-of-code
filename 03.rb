#!/usr/bin/env ruby
require 'pry'

data = File.read("data/03.txt").lines.map(&:strip)

data.map! do |datum|
  datum.split(/,|: |x/)
end

data.map! do |datum|
  datum.map! do |num|
    num.to_i
  end
end

taken = Hash.new { 0 }

data.each do |datum|
  x = datum.first
  i = 0
  while i < datum[2] do
    y = datum[1]
    j = 0
    while j < datum.last do
      taken[[x+i, y+j]] += 1
      j += 1
    end
    i += 1
  end
end

count = 0
taken.each do |took|
  if took[1] > 1
    count += 1
  end
end
puts count
