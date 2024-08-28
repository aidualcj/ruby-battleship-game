require 'board'
require 'ship'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:small_ship) { Ship.new(3) }
  let(:large_ship) { Ship.new(4) }

  before do
    board.place_ship(small_ship, 0, 0, :horizontal)
    board.place_ship(large_ship, 1, 0, :vertical)
  end

  describe '#shoot' do
    it 'returns "Hit" if a ship is hit' do
      expect(board.shoot(0, 0)).to eq('Hit')
    end

    it 'returns "Miss" if no ship is hit' do
      expect(board.shoot(4, 4)).to eq('Miss')
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
      board.shoot(1, 0)
      board.shoot(2, 0)
      board.shoot(3, 0)
      board.shoot(4, 0)
      expect(board.all_ships_sunk?).to be true
    end
  end
end
