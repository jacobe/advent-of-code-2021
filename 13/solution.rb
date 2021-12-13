def fold(dots, instruction)
  axis = instruction[1].to_i
  dim = instruction[0] == 'y' ? 1 : 0
  dots.filter { |d| d[dim] > axis }.each do |d|
    d[dim] -= 2 * (d[dim] - axis)
  end
end

def part1(dots, instructions)
  fold(dots, instructions[0])
  dots.uniq.length
end

def part2(dots, instructions)
  instructions.each do |inst|
    fold(dots, inst)
  end

  max_x = dots.map { |d| d[0] }.max
  max_y = dots.map { |d| d[1] }.max
  map = []
  (0..max_y).each do
    line = ['.'] * max_x * '' # build a string containing max_x dots
    map << line
  end
  dots.each do |d|
    map[d[1]][d[0]] = '#'
  end
  map
end

dots = []
instructions = []
File.readlines('input').map(&:strip).each do |line|
  if line.index('fold')
    instructions << line.gsub(/[xy]=\d+/).to_a[0].split('=')
  elsif !line.empty?
    dots << line.split(',').map(&:to_i)
  end
end

puts part2(dots, instructions)