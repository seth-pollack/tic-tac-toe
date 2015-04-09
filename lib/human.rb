require './lib/player'

class Human < Player
  def choose_place
    puts 'Please make your selection'
    print '> '
    num = gets.chomp
    fail 'Your selection must be a number' unless num =~ /\d+/
    num = num.to_i
    fail 'Your selection is unavailable, please try again..' unless @board.available_places.include?(num)
    num
  end

  def name
    'Human'
  end
end
