require 'set'

def part1(data)
  output_lengths = data.map { |d| d[1].map(&:length) }
  output_lengths.flatten.count do |l|
    l == 2 || l == 3 || l == 4 || l == 7
  end
end

class Array
  def remove(&condition)
    elem = find(&condition)
    delete(elem) if !elem.nil?
    return elem
  end
end

def part2(data)
  data.map do |line|
    input = line[0].map { |d| d.chars.to_set }
    digits = Array.new(10)
    digits[1] = input.remove { |d| d.length == 2 }
    digits[7] = input.remove { |d| d.length == 3 }
    digits[4] = input.remove { |d| d.length == 4 }
    digits[8] = input.remove { |d| d.length == 7 }
    digits[3] = input.remove do |d|
      d.length == 5 && d > digits[1]
    end
    digits[5] = input.remove do |d|
      d.length == 5 && d > (digits[4] - digits[1])
    end
    digits[2] = input.remove do |d|
      d.length == 5 && d != digits[5] && d != digits[3]
    end
    digits[9] = input.remove do |d|
      d.length == 6 && d > digits[4]
    end
    digits[6] = input.remove do |d|
      d.length == 6 && d > digits[5]
    end
    digits[0] = input[0]

    digits = digits.map(&:to_a).map(&:sort).map(&:join)
    output = line[1].map { |d| d.chars.sort.join }
    output.map { |d| digits.index(d) }.join.to_i
  end.sum
end

data = File.readlines('input').map do |line|
  line.split('|').map do |e|
    e.split(' ').map(&:strip)
  end
end

puts part2(data)
