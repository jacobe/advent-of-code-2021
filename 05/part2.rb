lines = File.readlines('input').map(&:chomp)
matrix = []

# init matrix
MATRIX_SIZE=1000
for x in 0..MATRIX_SIZE
  matrix << []
  for y in 0..MATRIX_SIZE
    matrix[x] << 0
  end
end

class Vector
  def initialize(x, y)
    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end

  def to_s
    "#{@x},#{@y}"
  end
end

# load vectors
for line in lines
  (v1, v2) = line.split('->').map(&:strip).map { |v| Vector.new(*v.split(',').map(&:to_i)) }

  s = v2.x < v1.x || v2.y < v1.y ? v2 : v1
  e = s == v1 ? v2 : v1

  delta_x = e.x == s.x ? 0 : (e.x - s.x).abs / (e.x - s.x)
  delta_y = e.y == s.y ? 0 : (e.y - s.y).abs / (e.y - s.y)

  x = s.x
  y = s.y

  steps = delta_x != 0 && delta_y == 0 ? (e.x - x).abs : (e.y - y).abs
  for step in 0..steps
    matrix[y][x] += 1
    x += delta_x
    y += delta_y
  end

  # puts matrix.map(&:to_s).join("\n")
end


# count overlaps
puts matrix.flatten.count { |v| v > 1 }
