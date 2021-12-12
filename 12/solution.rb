class Cave
  def initialize(label)
    @label = label
    @is_small = label.chars.all? { |c| 'a' <= c && c <= 'z' }
    @neighbours = []
  end

  def add_path(cave)
    @neighbours << cave
  end

  def label
    @label
  end

  def neighbours
    @neighbours
  end

  def is_small
    @is_small
  end

  def to_s
    @label
  end

  def inspect
    "#{@label}"
  end
end

CAVES = {}
PATHS = [] 

def part1(path, cave)
  path << cave
  if cave.label == 'end'
    PATHS << path
  end

  cave.neighbours.each do |neighbour|
    if neighbour.is_small && path.include?(neighbour)
      nil
    else
      part1(path.clone, neighbour)
    end
  end
end

def part2(path, cave)
  path << cave
  if cave.label == 'end'
    PATHS << path
    return path
  end

  cave.neighbours.each do |neighbour|
    if neighbour.is_small &&
      path.include?(neighbour) &&
      path.filter(&:is_small).uniq.any? { |n| path.count(n) >= 2 }
      nil
    else
      part2(path.clone, neighbour)
    end
  end
end

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

part1([], CAVES['start'])
puts "#{PATHS.length}"
