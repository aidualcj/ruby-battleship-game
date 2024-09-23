require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/ship'

RSpec.describe Game do
  let(:game) { Game.new("Player 1", "Player 2") }
  let(:player1) { game.player1 }
  let(:player2) { game.player2 }

  before do
    allow(player1).to receive(:gets).and_return('0 0 horizontal', '1 0 horizontal')
    allow(player2).to receive(:gets).and_return('0 0 horizontal', '1 0 horizontal')

    allow(player1).to receive(:place_ships)
    allow(player2).to receive(:place_ships)

    allow(player1).to receive(:take_turn)
    allow(player2).to receive(:take_turn)
  end

  describe '#play_game' do
    it 'declares a winner for a single game' do
      allow(player1.board).to receive(:all_ships_sunk?).and_return(false, true)
      expect { game.play_game }.to output(/(Player 1|Player 2) will start the game!.*Player 1 wins this game!/m).to_stdout
    end
  end

  describe '#play_match' do
    it 'Player 1 wins the match by winning two games' do
      allow(game).to receive(:play_game).and_return(player1, player1)
      expect { game.play_match }.to output(/Player 1 wins the match!/).to_stdout
    end

    it 'Player 2 wins the match by winning two games' do
      allow(game).to receive(:play_game).and_return(player2, player2)
      expect { game.play_match }.to output(/Player 2 wins the match!/).to_stdout
    end

    it 'alternates wins between players and reaches the third game' do
      allow(game).to receive(:play_game).and_return(player1, player2, player2)
      expect { game.play_match }.to output(/Player 2 wins the match!/).to_stdout
    end
  end
end
