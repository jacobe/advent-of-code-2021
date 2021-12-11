def median(array)
  return nil if array.empty?
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

def part1(positions)
  position = median(positions)
  positions.sum { |p| (position - p).abs }
end

def part2(positions)
  positions.min.upto(positions.max).map do |pos|
    positions.sum { |p| (pos - p).abs.downto(1).sum }
  end.min
end

positions = File.readlines('input')[0].split(',').map(&:to_i)
puts part2(positions)
