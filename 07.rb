#!/usr/bin/env ruby
require 'pry'

data = File.read("data/07.txt").lines.map! do |line|
  line = line.split(' ')
  [line[1].downcase, line[7].downcase]
end

class Letter
  def initialize(char)
    @char = char
    @requirements = []
  end

  def char
    @char
  end

  def require(char)
    @requirements << char
  end

  def requirements
    @requirements
  end

  def delete_requirement(char)
    @requirements.delete(char)
  end
end

chars = []
('a'..'z').each do |char|
  chars << char
end 

letters = []
chars.each do |char|
  letter = Letter.new(char)
  letters << letter
end 

data.each do |datum|
  letters.each do |letter|
    if letter.char == datum[1]
      letter.require(datum[0])
    end
  end
end

order = []
deletions = []
while letters != []
  letters.each do |letter|
    if letter.requirements == []
      order << letter.char
      letters.delete(letter)

      letters.each do |remaining|
        remaining.delete_requirement(letter.char)
      end
      break
    end
  end
end
puts order
