class Player
  attr_accessor :marker
  def initialize(board)
    @board = board
  end

  def choose_place
    fail 'undefined method'
  end
end
