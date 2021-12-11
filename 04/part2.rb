lines = File.readlines('input').map(&:chomp)
numbers = lines[0].split(',').map(&:to_i)
boards = []

class Board
  def initialize
    @rows = []
    @marked = []
    @score = 0
    @last_number
  end

  def add_line(line)
    row = line.split(' ').map(&:chomp).map(&:to_i)
    @score += row.sum
    @rows << row
    @marked = @rows.clone
  end

  def is_winner?
    return true if @marked.any? { |r| r.all? { |c| c == -1 } }
    for c in 0..@marked[0].length
      return true if @marked.all? { |r| r[c] == -1 }
    end
    return false
  end

  def mark(number)
    for r in 0..@marked.length-1
      c = @marked[r].index(number)
      if number == 16
        puts "Found? #{c}"
      end
      if !c.nil?
        @score -= @marked[r][c]
        @last_number = number
        @marked[r][c] = -1
        puts "Marked #{number} at #{r}x#{c}"
        break
      end
    end
  end

  def score
    @score * @last_number
  end

  def to_s
    return "#{@rows.map(&:to_s).join("\n")}"
  end
end

# Initialize boards
board = nil
lines.each_with_index do |line, i|
  next if i == 0
  if line == ''
    board = Board.new()
    boards << board
    next
  end
  board.add_line(line)
end

def play_bingo(boards, numbers)
  for number in numbers
    puts "Calling #{number} (boards left: #{boards.length})"
    for board in boards.clone
      board.mark(number)
      if board.is_winner?
        puts "Bingo!"
        if boards.length == 1
          return board
        end
        boards.delete(board)
      end
    end
  end
end

loser = play_bingo(boards, numbers)
puts "Loser is:\n#{loser}"
puts "Score: #{loser.score}"
