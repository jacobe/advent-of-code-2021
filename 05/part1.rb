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

# load vectors
for line in lines
  (vec_start, vec_end) = line.split('->').map(&:strip).map { |v| v.split(',').map(&:to_i) }
  
  if vec_start[0] == vec_end[0]
    if vec_start[1] > vec_end[1]
      tmp = vec_end[1]
      vec_end[1] = vec_start[1]
      vec_start[1] = tmp
    end
    for y in vec_start[1]..vec_end[1]
      matrix[y][vec_start[0]] += 1
    end
  end

  if vec_start[1] == vec_end[1]
    if vec_start[0] > vec_end[0]
      tmp = vec_end[0]
      vec_end[0] = vec_start[0]
      vec_start[0] = tmp
    end
    for x in vec_start[0]..vec_end[0]
      matrix[vec_start[1]][x] += 1
    end
  end

end

# count overlaps
puts matrix.flatten.count { |v| v > 1 }