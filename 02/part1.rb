file = File.open("input")
commands = file.readlines.map(&:split)

depth = 0
pos = 0
for c in commands
  cmd = c[0]
  amount = c[1].to_i
  puts "c #{c}"
  if cmd == "forward"
    pos += amount
  elsif cmd == "down"
    depth += amount
  elsif cmd == "up"
    depth -= amount
  end
end

puts "#{depth} * #{pos} = #{depth*pos}"