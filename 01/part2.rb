file = File.open("input")
depths = file.readlines.map(&:to_i)

window = []
counter = 0
for d in depths
  sumBefore = window.sum()
  window << d
  if window.length > 3
    window.shift()
    counter += 1 if window.sum() > sumBefore
    puts "#{window.sum()} #{window.sum() > sumBefore ? "inc" : "dec"}"
  end
end

puts counter