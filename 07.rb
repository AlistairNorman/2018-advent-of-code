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

data = File.read("data/07.txt").lines.map! do |line|
  line = line.split(' ')
  [line[1].downcase, line[7].downcase]
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

class Worker
  def initialize()
    @assignment = nil
    @seconds_left = 0
    @hash = Hash.new
    i = 1
    ('a'..'z').each do |character|
      @hash[character] = i
      i += 1
    end
  end

  def assignment
    @assignment
  end

  def assign(char)
    @assignment = char
    @seconds_left = @hash[char.char] + 60
    puts @seconds_left
  end

  def find_assignment(letters)
    doable = find_letters(letters)
    if doable != []
      self.assign(doable.first)
    end
    letters.delete(self.assignment)
  end

  def finish
    @assignment = nil
    @seconds_left = -1
  end

  def work
    @seconds_left -= 1
  end

  def time_left
    @seconds_left
  end
end

worker1 = Worker.new
worker2 = Worker.new

def find_letters(letters)
  doable = []
  letters.each do |letter|
    if letter.requirements == []
      doable << letter
    end
  end
  doable
end

i = 0
while worker1.time_left > 0 || worker2.time_left > 0 || i < 100 
  worker1.work
  worker2.work

  if worker1.time_left <= 0
    unless worker1.assignment == nil
      letters.each do |remaining|
        remaining.delete_requirement(worker1.assignment.char)
      end
    end
    worker1.find_assignment(letters)
  end

  if worker2.time_left <= 0
    unless worker2.assignment == nil
      letters.each do |remaining|
        remaining.delete_requirement(worker2.assignment.char)
      end
    end
    worker2.find_assignment(letters)
  end

  if worker1.time_left <= 0
    worker1.find_assignment(letters)
  end

  i += 1
end
puts i
