STEPS=1000
WIDTH=10
HEIGHT=10

def part1(data)
  flash_counter = 0
  for step in 0...STEPS
    flashes = []
    for y in 0...HEIGHT
      for x in 0...WIDTH
        data[y][x] += 1
        if data[y][x] == 10
          flashes << [x, y]
        end
      end
    end

    inc = lambda { |x, y|
      data[y][x] += 1 if data[y][x] > 0
      if data[y][x] == 10
        flashes << [x, y]
      end
    }

    while flashes.length
      x, y = flashes.pop
      break if x.nil? || y.nil?
      data[y][x] = 0
      flash_counter += 1
      
      if x > 0
        inc.call(x-1, y)
        inc.call(x-1, y-1) if y > 0
        inc.call(x-1, y+1) if y < HEIGHT-1
      end
      inc.call(x, y-1) if y > 0
      inc.call(x, y+1) if y < HEIGHT-1
      if x < WIDTH-1
        inc.call(x+1, y) 
        inc.call(x+1, y-1) if y > 0
        inc.call(x+1, y+1) if y < HEIGHT-1
      end
    end
  end
  flash_counter
end

def part2(data)
  for step in 0...STEPS
    flashes = []

    if data.all? { |d| d.all? { |n| n == 0 } }
      return step
    end

    for y in 0...HEIGHT
      for x in 0...WIDTH
        data[y][x] += 1
        if data[y][x] == 10
          flashes << [x, y]
        end
      end
    end

    inc = lambda { |x, y|
      data[y][x] += 1 if data[y][x] > 0
      if data[y][x] == 10
        flashes << [x, y]
      end
    }

    while flashes.length
      x, y = flashes.pop
      break if x.nil? || y.nil?
      data[y][x] = 0
      
      if x > 0
        inc.call(x-1, y)
        inc.call(x-1, y-1) if y > 0
        inc.call(x-1, y+1) if y < HEIGHT-1
      end
      inc.call(x, y-1) if y > 0
      inc.call(x, y+1) if y < HEIGHT-1
      if x < WIDTH-1
        inc.call(x+1, y) 
        inc.call(x+1, y-1) if y > 0
        inc.call(x+1, y+1) if y < HEIGHT-1
      end
    end
  end
end

data = File.readlines('input').map do |line|
  line.strip.chars.map(&:to_i)
end

puts part2(data).to_s