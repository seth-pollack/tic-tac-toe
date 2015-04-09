require 'matrix'

class Board
  attr_reader :board, :size

  def initialize(size)
    @size = size
    create_board
  end

  def create_board
    @board = (1..size**2).each_slice(size).to_a
  end

  def available_places
    board.flatten.select { |n| n.to_s =~ /\d+/ }
  end

  def place_marker(marker, position)
    x, y = convert_to_cords(position)
    begin
      board[x][y] = marker
    rescue
      raise "#{position} is an invalid position"
    end
  end

  def check_for_win(marker)
    check_horizontal(marker) || check_vertical(marker) ||
      check_right_diag(marker) || check_left_diag(marker)
  end

  def to_s
    print = board.flatten.map do |e|
      s = e.to_s
      s.length == 1 ? ' ' + s : s
    end.each_slice(size).to_a
    print.map { |row| row.join(' | ') }.join("\n" + split + "\n")
  end

  private

  def split
    (1...size).inject('---') { |s| s + '+----' }
  end

  def convert_to_cords(position)
    Matrix.build(size).to_a[position - 1]
  end

  def check_horizontal(marker)
    board.any? { |row| row.all? { |e| e == marker } }
  end

  def check_vertical(marker)
    board.transpose.any? { |col| col.all? { |e| e == marker } }
  end

  def check_right_diag(marker)
    (0...size).collect { |i| board[i][((size) - 1) - i] }
      .all? { |e| e == marker }
  end

  def check_left_diag(marker)
    (0...size).collect { |i| board[i][i] }
      .all? { |e| e == marker }
  end
end
