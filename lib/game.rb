require_relative 'board'
require_relative 'ship'
require_relative 'player'

class Game
  attr_reader :player1, :player2

  def initialize(player1_name, player2_name)
    @player1 = Player.new(player1_name)
    @player2 = Player.new(player2_name)
  end

  def play_game
    current_player = [@player1, @player2].sample
    opponent_board = current_player == @player1 ? @player2.board : @player1.board

    puts "#{current_player.name} will start the game!"

    loop do
      current_player.take_turn(opponent_board)

      if opponent_board.all_ships_sunk?
        puts "#{current_player.name} wins this game!"
        return current_player
      end

      # Switch players
      current_player = current_player == @player1 ? @player2 : @player1
      opponent_board = current_player == @player1 ? @player2.board : @player1.board
    end
  end

  def play_match
    player1_score = 0
    player2_score = 0

    until player1_score == 2 || player2_score == 2
      @player1.board = Board.new
      @player2.board = Board.new

      puts "Player 1, place your ships:"
      @player1.place_ships
      puts "Player 2, place your ships:"
      @player2.place_ships

      winner = play_game

      if winner == @player1
        player1_score += 1
      else
        player2_score += 1
      end

      puts "Current Score: Player 1 - #{player1_score}, Player 2 - #{player2_score}"
    end

    if player1_score > player2_score
      puts "Player 1 wins the match!"
    else
      puts "Player 2 wins the match!"
    end
  end

  def play_again?
    puts "Do you want to play again? (yes/no)"
    answer = gets.chomp.downcase
    answer == 'yes'
  end
end
