file = File.open("input")
rows = file.readlines

gamma_bits = []
ypsilon_bits = []
for i in 0..rows[0].length-2
  sum = 0
  for row in rows
    sum += row[i].to_i
  end
  common_bit = (sum > rows.length/2 ? 1 : 0)
  gamma_bits << common_bit
  ypsilon_bits << (common_bit == 1 ? 0 : 1)
end
puts "#{gamma_bits} = #{gamma_bits.join.to_i(2)}"
puts "#{ypsilon_bits} = #{ypsilon_bits.join.to_i(2)}"

puts "Power consumption: #{gamma_bits.join.to_i(2) * ypsilon_bits.join.to_i(2)}"