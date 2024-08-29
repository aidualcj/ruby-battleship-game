require_relative 'lib/board'
require_relative 'lib/ship'
require_relative 'lib/player'

if __FILE__ == $0
  puts "=========================================="
  puts "       WELCOME TO BATTLESHIP GAME!        "
  puts "=========================================="
  puts
  puts "Rules of the Game:"
  puts "- The game is played on a 5x5 grid."
  puts "- Each player places 2 ships on the grid:"
  puts "  * One ship of size 3"
  puts "  * One ship of size 4"
  puts "- Ships can be placed horizontally, vertically, diagonal_right, or diagonal_left."
  puts "- Players take turns to guess the location of the opponent's ships."
  puts "- The first player to sink all opponent's ships wins the game."
  puts
  puts "Match Mode: Best of 3"
  puts "- The first player to win two games wins the match."
  puts "- A match can last up to three games."
  puts
  puts "Good luck!"
  puts "=========================================="
  puts
end

def play_game(player1, player2)
  # Logic for playing a single game
end

def play_match(player1, player2)
  player1_score = 0
  player2_score = 0

  # Continue the match until one player wins two games
  until player1_score == 2 || player2_score == 2
    # Reset the boards for both players
    player1.board = Board.new
    player2.board = Board.new

    # Place ships for both players
    puts "Player 1, place your ships:"
    player1.place_ships
    puts "Player 2, place your ships:"
    player2.place_ships

    # Start the game
    current_player = [player1, player2].sample
    opponent_board = current_player == player1 ? player2.board : player1.board

    puts "#{current_player.name} will start the game!"

    loop do
      current_player.take_turn(opponent_board)

      if opponent_board.all_ships_sunk?
        puts "#{current_player.name} wins this game!"
        if current_player == player1
          player1_score += 1
        else
          player2_score += 1
        end
        break
      end

      # Switch players
      current_player = current_player == player1 ? player2 : player1
      opponent_board = current_player == player1 ? player2.board : player1.board
    end

    puts "Current Score: Player 1 - #{player1_score}, Player 2 - #{player2_score}"
  end

  # Announce the match winner
  if player1_score > player2_score
    puts "Player 1 wins the match!"
  else
    puts "Player 2 wins the match!"
  end
end

# Main game loop to allow replaying
loop do
  player1 = Player.new("Player 1")
  player2 = Player.new("Player 2")

  play_match(player1, player2)

  puts "Do you want to play again? (yes/no)"
  answer = gets.chomp.downcase
  break unless answer == 'yes'
end

puts "Thanks for playing!"
