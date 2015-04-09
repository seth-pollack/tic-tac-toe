require './lib/player'

class Computer < Player
  def choose_place
    puts 'Computers advanced AI is thinking...'
    sleep 1
    @board.available_places.sample
  end

  def name
    'Computer'
  end
end
