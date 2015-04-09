require './lib/board'
require './lib/player'
require './lib/human'
require './lib/computer'

class Game
  def initialize
    setup_board
    setup_players
    run_game
  end

  def self.start
    loop do
      Game.new
      puts 'Would you like to play again? (Y/N)'
      break unless gets.chomp.upcase == 'Y'
    end
    puts "\e[H\e[2J"
    puts 'Thanks for playing. Goodbye!'
  end

  def choose_board_size
    welcome_screen
    begin
      return get_valid_number gets
    rescue => e
      puts e
      retry
    end
  end

  def setup_board
    size = choose_board_size
    @board = Board.new(size)
  end

  def choose_marker(used_marker = nil)
    return used_marker == :X ? :O : :X if used_marker
    choose_marker_screen
    begin
      marker = get_valid_number(gets)
      fail 'Please choose 1 or 2' unless marker < 3
      marker == 1 ? :X : :O
    rescue => e
      puts e
      retry
    end
  end

  def setup_players
    @players = []
    @players << human = Human.new(@board)
    @players << computer = Computer.new(@board)
    marker = human.marker = choose_marker
    computer.marker = choose_marker(marker)
  end

  def run_game
    players = @players.shuffle.cycle
    loop do
      game_screen
      current_player = players.next
      marker = current_player.marker

      begin
        move = current_player.choose_place
        @board.place_marker(marker, move)
      rescue => e
        puts e
        retry
      end

      game_screen

      if @board.check_for_win(marker)
        puts "#{current_player.name} wins!"
        break
      elsif @board.available_places.empty?
        puts 'its a draw!'
        break
      end
    end
  end

  private

  def get_valid_number(num)
    fail 'Your selection must be a number' unless num =~ /\d+/
    num.to_i
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  # views
  def game_screen
    clear_screen
    puts @board.to_s
    puts '                                 '
    puts '                                 '
    puts '                                 '
    puts '                                 '
  end

  def welcome_screen
    clear_screen
    puts '-- Welcome to Ruby Tic Tac Toe --'
    puts '    Please enter a board size    '
    puts '                                 '
    puts '                                 '
    puts '                                 '
    puts '                                 '
    print '> '
  end

  def choose_marker_screen
    clear_screen
    puts '-- Welcome to Ruby Tic Tac Toe --'
    puts '                                 '
    puts '         (1) for X               '
    puts '         (2) for O               '
    puts '                                 '
    puts '                                 '
    print '> '
  end
end
