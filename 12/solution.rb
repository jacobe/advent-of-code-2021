class Cave
  attr_reader :label, :is_small, :neighbours

  def initialize(label)
    @label = label
    @is_small = label.chars.all? { |c| 'a' <= c && c <= 'z' }
    @neighbours = []
  end

  def add_path(cave)
    @neighbours << cave
  end

  def inspect
    "#{@label}"
  end
end

def part1(path, cave)
  return 1 if cave.label == 'end'
  cave.neighbours.map do |neighbour|
    if !(neighbour.is_small && path.include?(neighbour))
      part1([*path, cave], neighbour)
    end
  end.compact.sum
end

def part2(path, cave)
  return 1 if cave.label == 'end'
  cave.neighbours.map do |neighbour|
    if !(neighbour.is_small &&
      path.include?(neighbour) &&
      path.filter(&:is_small).uniq.any? { |n| path.count(n) >= 2 })
      part2([*path, cave], neighbour)
    end
  end.compact.sum
end

CAVES = {}

# Read all the caves and add paths between them
File.readlines('input').map do |line|
  from, to = line.strip.split('-')

  if !CAVES[from]
    CAVES[from] = Cave.new(from)
  end
  from = CAVES[from]

  if !CAVES[to]
    CAVES[to] = Cave.new(to)
  end
  to = CAVES[to]

  from.add_path(to) unless to.label == 'start' || from.label == 'end'
  to.add_path(from) unless from.label == 'start' || to.label == 'end'
end

# Calculate the number of valid paths
puts part2([], CAVES['start'])
