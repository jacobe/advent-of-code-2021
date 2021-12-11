BRACKETS = {
  '[': ']',
  '<': '>',
  '{': '}',
  '(': ')'
}

SYNTAX_CHECK_POINTS = {
  ')': 3,
  ']': 57,
  '}': 1197,
  '>': 25137
}

AUTOCOMPLETE_POINTS = {
  '(': 1,
  '[': 2,
  '{': 3,
  '<': 4
}

def check_syntax(line)
  open_chunks = []
  for i in 0...line.length
    char = line[i]
    if BRACKETS.keys.include?(char.to_sym)
      open_chunks.push(char)
    else
      if char != BRACKETS[open_chunks.pop().to_sym]
        # Syntax error
        return SYNTAX_CHECK_POINTS[char.to_sym]
      end
    end
  end
  0
end

def autocomplete(line)
  open_chunks = []
  for i in 0...line.length
    char = line[i]
    if BRACKETS.keys.include?(char.to_sym)
      open_chunks.push(char)
    else
      if char != BRACKETS[open_chunks.pop().to_sym]
        # Syntax error
        return
      end
    end
  end
  open_chunks.reverse.inject(0) { |sum, c| sum * 5 + AUTOCOMPLETE_POINTS[c.to_sym] }
end

def part1(lines)
  lines.map do |line|
    check_syntax(line)
  end.sum
end

def part2(lines)
  points = lines.map do |line|
    autocomplete(line)
  end.filter { |p| !p.nil? }.sort
  points[points.length/2]
end

data = File.readlines('input').map do |line|
  line.strip
end

puts part2(data).to_s