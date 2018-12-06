#!/usr/bin/env ruby
require 'pry'

data = File.read("data/06.txt").lines.map(&:strip)
data.map! do |datum|
  datum.split(", ")
end
data.map! do |datum|
  { x: datum[0].to_i, y: datum[1].to_i }
end


class Grid
  def initialize(size)
    @grid = []
    i = 0
    while i < size do
      j = 0
      while j < size do
        @grid << { x: i, y: j, closest_point: { x: -10000, y: -10000  } }
        j += 1
      end
      i += 1
    end
  end

  def points
    @grid
  end
end

def distance(p1, p2)
  (p1[:x] + p1[:y] - p2[:x] - p2[:y]).abs
end

def closest(data, point)
  closest_points = []
  closest_point = {x: 100000, y: 100000}
  data.each do |datum|
    if distance(datum, point) < distance(closest_point, point)
      closest_point = datum
      closest_points = [datum]
    elsif distance(datum, point) == distance(closest_point, point)
      closest_points << datum
    end
  end
  if closest_points.count == 1
    closest_point
  else
    nil
  end
end

grid = Grid.new(500)
grid.points.each do |point|
  point[:closest_point] = closest(data, { x: point[:x], y: point[:y] })
end
  
count = Hash.new { 0 }
grid.points.each do |point|
  count[point[:closest_point]] += 1
end
count = count.sort_by {|_key, value| value}

total = 0
count.each do |value|
  total += value[1]
end
puts total





