require 'board'
require 'ship'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:ship) { Ship.new(3) }

  before do
    board.place_ship(ship, 0, 0, :horizontal)
  end

  describe '#shoot' do
    it 'returns "Hit" if a ship is hit' do
      expect(board.shoot(0, 0)).to eq('Hit')
    end

    it 'returns "Miss" if no ship is hit' do
      expect(board.shoot(1, 1)).to eq('Miss')
    end

    it 'returns "Out of bounds" for shots outside the grid' do
      expect(board.shoot(5, 5)).to eq('Out of bounds')
    end

    it 'returns "Already shot here" if the cell was already shot' do
      board.shoot(0, 0)
      expect(board.shoot(0, 0)).to eq('Already shot here')
    end

    it 'returns "Sink" if a ship is sunk' do
      board.shoot(0, 0)
      board.shoot(0, 1)
      expect(board.shoot(0, 2)).to eq('Sink')
    end

    it 'confirms all ships are sunk' do
      board.shoot(0, 0)
      board.shoot(0, 1)
      board.shoot(0, 2)
      expect(board.all_ships_sunk?).to be true
    end
  end
end
