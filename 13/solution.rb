def part1(dots, instructions)
  for inst in instructions
    axis = inst[1].to_i
    dim = inst[0] == 'y' ? 1 : 0
    dots.filter { |d| d[dim] > axis }.each do |d|
      d[dim] -= 2 * (d[dim] - axis)
    end
    break
  end
  dots.uniq.length
end

def part2(dots, instructions)
  for inst in instructions
    axis = inst[1].to_i
    dim = inst[0] == 'y' ? 1 : 0
    dots.filter { |d| d[dim] > axis }.each do |d|
      d[dim] -= 2 * (d[dim] - axis)
    end
  end

  max_x = dots.map { |d| d[0] }.max
  max_y = dots.map { |d| d[1] }.max
  map = []
  for y in 0..max_y
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