#!/usr/bin/env ruby
require 'pry'

data = File.read("data/05.txt")
  
length = 0
while length != data.length do
  ('a'..'z').to_a.each do |char|
    length = data.length
    data.gsub!(/#{char}#{char.upcase}|#{char.upcase}#{char}/, '')
  end
end

puts length
