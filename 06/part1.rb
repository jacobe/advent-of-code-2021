ages = File.readlines('input')[0].split(',').map(&:strip).map(&:to_i)
blocks = ages.map { |a| [a, 1] } 

DAYS = 256
INITIAL_AGE = 8
RESET_AGE = 6
for day in 0..DAYS-1
  new_block = nil
  count = blocks.length
  for i in 0..count-1
    if blocks[i][0] == 0
      if new_block.nil?
        new_block = [INITIAL_AGE, blocks[i][1]]
      else
        new_block[1] += blocks[i][1]
      end
      blocks[i][0] = RESET_AGE
    else
      blocks[i][0] += -1
    end
  end
  blocks.push(new_block) unless new_block.nil?
end
puts blocks.to_s
puts blocks.map { |a| a[1] }.sum
