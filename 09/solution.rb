def part1(map)
  map.each_with_index.map do |line, i|
    lowpoints = line.each_with_index.filter do |n, j|
      nearby = []
      nearby.push(line[j-1]) if j > 0
      nearby.push(line[j+1]) if j < line.length-1
      nearby.push(map[i-1][j]) if i > 0
      nearby.push(map[i+1][j]) if i < map.length-1
      nearby.all? { |d| d > n }
    end
    lowpoints.map { |p| p[0] + 1 }.sum
  end.sum
end

def crawl(map, n, x, y)
  return 0 if map[y][x][1]
  map[y][x][1] = true
  val = map[y][x][0]
  return 0 if val == 9
  n = 1
  n += crawl(map, val, x-1, y) if x > 0
  n += crawl(map, val, x+1, y) if x < map[y].length-1
  n += crawl(map, val, x, y-1) if y > 0
  n += crawl(map, val, x, y+1) if y < map.length-1
  n
end

def part2(data)
  lowpoints = data.each_with_index.map do |line, i|
    line.each_with_index.filter do |n, j|
      nearby = []
      nearby.push(line[j-1]) if j > 0
      nearby.push(line[j+1]) if j < line.length-1
      nearby.push(data[i-1][j]) if i > 0
      nearby.push(data[i+1][j]) if i < data.length-1
      nearby.all? { |d| d > n }
    end.map { |p| [i, p[1]] }
  end.flatten(1)

  map = data.map { |line| line.map { |n| [n, false] } }
  sizes = lowpoints.map do |p|
    crawl(map, map[p[0]][p[1]][0], p[1], p[0])
  end.sort.reverse

  sizes[0] * sizes[1] * sizes[2]
end

data = File.readlines('input').map do |line|
  line.strip.chars.map do |e|
    e.to_i
  end
end

puts data.map(&:to_s).join("\n")
puts part2(data).to_s
