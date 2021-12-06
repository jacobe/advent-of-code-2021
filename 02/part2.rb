file = File.open("input")
commands = file.readlines.map(&:split)

depth = 0
pos = 0
aim = 0
for c in commands
  cmd = c[0]
  amount = c[1].to_i
  puts "c #{c}"
  if cmd == "forward"
    pos += amount
    depth += aim * amount
  elsif cmd == "down"
    aim += amount
  elsif cmd == "up"
    aim -= amount
  end
end

puts "#{depth} * #{pos} = #{depth*pos}"