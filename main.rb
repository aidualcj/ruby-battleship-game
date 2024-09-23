require_relative 'lib/game'

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

  loop do
    game = Game.new("Player 1", "Player 2")
    game.play_match

    break unless game.play_again?
  end

  puts "Thanks for playing!"
end
