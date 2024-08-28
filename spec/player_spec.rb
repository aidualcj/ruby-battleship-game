require'player'
require'board'
require'ship'

RSpec.describe Player do
  let(:player) { Player.new("Alice") }
  let(:opponent_board) { Board.new }

  describe '#initialize' do
    it 'creates a player with a name and a board' do
      expect(player.name).to eq("Alice")
      expect(player.board).to be_instance_of(Board)
    end
  end

  describe '#place_ships' do
    it 'allows the player to place ships on their board' do
      # Simulate valid input for the first ship
      allow(player).to receive(:gets).and_return('0 0 horizontal', '0 0 horizontal', '1 1 horizontal')

      player.place_ships

      expect(player.board.instance_variable_get(:@grid)[0][0]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[0][1]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[0][2]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[1][1]).to eq('S')
    end
  end
end
