require'player'
require'board'
require'ship'

RSpec.describe Player do
  let(:player) { Player.new("Alice") }
  let(:opponent_board) { Board.new }
  let(:ship) { Ship.new(3) }

  before do
    opponent_board.place_ship(ship, 0, 0, :horizontal)
  end

  describe '#take_turn' do
    it 'allows the player to shoot at the opponent board and displays the result' do
      allow(player).to receive(:gets).and_return('0 0')
      expect(opponent_board).to receive(:shoot).with(0, 0).and_return('Hit')
      expect { player.take_turn(opponent_board) }.to output(/Hit/).to_stdout
    end
  end
end
