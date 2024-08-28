require_relative 'lib/board'
require_relative 'lib/ship'
require_relative 'lib/player'

# Initialize players
player1 = Player.new("Player 1")
player2 = Player.new("Player 2")

# Place ships for both players
puts "Player 1, place your ships:"
player1.place_ships
puts "Player 2, place your ships:"
player2.place_ships

# Game loop for taking turns
current_player = player1
opponent_board = player2.board

loop do
  current_player.take_turn(opponent_board)

  # Check if the current player has won ?
  if opponent_board.all_ships_sunk?
    puts "#{current_player.name} wins!"
    break
  end

  # Switch players
  current_player = current_player == player1 ? player2 : player1
  opponent_board = current_player == player1 ? player2.board : player1.board
end
