require_relative 'lib/board'
require_relative 'lib/ship'
require_relative 'lib/player'

# Define the play_game method
def play_game
  # Initialize players
  player1 = Player.new("Player 1")
  player2 = Player.new("Player 2")

  # Place ships for both players
  puts "Player 1, place your ships:"
  player1.place_ships
  puts "Player 2, place your ships:"
  player2.place_ships

  # Randomly determine the starting player
  current_player = [player1, player2].sample
  opponent_board = current_player == player1 ? player2.board : player1.board

  puts "#{current_player.name} will start the game!"

  # Game loop for taking turns
  loop do
    current_player.take_turn(opponent_board)

    # Check if the current player has won
    if opponent_board.all_ships_sunk?
      puts "#{current_player.name} wins!"
      break
    end

    # Switch players
    current_player = current_player == player1 ? player2 : player1
    opponent_board = current_player == player1 ? player2.board : player1.board
  end
end

# Main game loop to allow replaying
loop do
  play_game
  puts "Do you want to play again? (yes/no)"
  answer = gets.chomp.downcase
  break unless answer == 'yes'
end

puts "Thanks for playing!"
