file = File.open("input")
rows = file.readlines.map(&:chomp)

oxygen = rows.clone
co2 = rows.clone
for i in 0..rows[0].length-1
  if oxygen.length > 1
    sum = oxygen.map { |r| r[i].to_i }.sum
    common_bit = (sum >= oxygen.length.to_f/2 ? 1 : 0)
    oxygen = oxygen.filter { |row| row[i].to_i == common_bit }
  end
  if co2.length > 1
    sum = co2.map { |r| r[i].to_i }.sum
    common_bit = (sum >= co2.length.to_f/2 ? 1 : 0)
    co2 = co2.filter { |row| row[i].to_i != common_bit }
  end
end

puts "Oxygen: #{oxygen} #{oxygen.join().to_i(2)}"
puts "CO2: #{co2} #{co2.join.to_i(2)}"
puts "Life support rating: #{oxygen.join().to_i(2) * co2.join.to_i(2)}"