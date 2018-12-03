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

def claim(datum)
  claim = []
  x = datum.first
  i = 0
  while i < datum[2] do
    y = datum[1]
    j = 0
    while j < datum.last do
      claim << [x+i, y+j]
      j += 1
    end
    i += 1
  end
  claim
end

def intersecting?(claim1, claim2)
  if (claim1 + claim2).uniq.count == (claim1.count + claim2.count) || claim1 == claim2
    return false
  end
  return true
end


claims = []
data.each do |datum|
  claims << claim(datum)
end

iterations = 0
claimscount = 0
claims.each do |claim1|
  intersecting = false
  claims.each do |claim2|
    if intersecting?(claim1, claim2)
      intersecting =  true
      break
    end
  end
  unless intersecting
    puts claim1
  end
end
