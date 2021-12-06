file = File.open("input")
depths = file.readlines.map(&:to_i)

prev = nil
counter = 0
for d in depths
  counter += 1 unless prev.nil? || prev >= d
  prev = d
end

puts counter