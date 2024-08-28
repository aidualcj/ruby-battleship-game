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

# Display the boards to verify ship placement
puts "\nPlayer 1's Board:"
player1.board.display
puts "\nPlayer 2's Board:"
player2.board.display

puts "Ship placement complete. Ready for Step 2!"
