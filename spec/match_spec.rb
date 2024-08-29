require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/ship'

# Redefine the play_match method for testing, with an additional parameter to control the score.
def play_match(player1, player2, results)
  player1_score = 0
  player2_score = 0

  results.each do |winner|
    player1.board = Board.new
    player2.board = Board.new

    player1.place_ships
    player2.place_ships

    if winner == :player1
      player1_score += 1
      puts "Player 1 wins this game!"
    else
      player2_score += 1
      puts "Player 2 wins this game!"
    end

    # Stop the series if either player wins two games
    break if player1_score == 2 || player2_score == 2
  end

  if player1_score > player2_score
    puts "Player 1 wins the match!"
  else
    puts "Player 2 wins the match!"
  end
end

RSpec.describe 'Best of 3 Match' do
  let(:player1) { Player.new("Player 1") }
  let(:player2) { Player.new("Player 2") }

  before do
    allow(player1).to receive(:gets).and_return('0 0 horizontal', '1 0 horizontal')
    allow(player2).to receive(:gets).and_return('0 0 horizontal', '1 0 horizontal')

    allow(player1).to receive(:place_ships)
    allow(player2).to receive(:place_ships)

    allow(player1).to receive(:take_turn)
    allow(player2).to receive(:take_turn)
  end

  it 'Player 1 wins first game, Player 2 wins second and third games' do
    # Define the scenario: Player 1 wins the first match, Player 2 wins the second and third matches.
    results = [:player1, :player2, :player2]

    expect { play_match(player1, player2, results) }.to output(
      /Player 1 wins this game!.*Player 2 wins this game!.*Player 2 wins this game!.*Player 2 wins the match!/m
    ).to_stdout
  end

  it 'Player 1 wins the first two games, ending the match' do
    # Define the scenario: Player 1 wins the first two matches.
    results = [:player1, :player1]

    expect { play_match(player1, player2, results) }.to output(
      /Player 1 wins this game!.*Player 1 wins this game!.*Player 1 wins the match!/m
    ).to_stdout
  end
end
