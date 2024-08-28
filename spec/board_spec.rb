require 'board'
require 'ship'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:ship) { Ship.new(3) }

  describe '#initialize' do
    it 'initializes a 5x5 grid' do
      expect(board.instance_variable_get(:@grid).size).to eq(5)
      expect(board.instance_variable_get(:@grid).all? { |row| row.size == 5 }).to be true
    end
  end

  describe '#display' do
    it 'displays the grid in the console' do
      expect { board.display }.to output.to_stdout
    end
  end

  describe '#place_ship' do
    it 'places a ship on the board' do
      board.place_ship(ship, 0, 0, :horizontal)
      expect(board.instance_variable_get(:@grid)[0][0]).to eq('S')
    end
  end

  describe '#valid_position?' do
    let(:ship) { Ship.new(3) }

    it 'returns true for a valid position' do
      expect(board.valid_position?(ship, 0, 0, :horizontal)).to be true
    end

    it 'returns false for an invalid position out of bounds' do
      expect(board.valid_position?(ship, 4, 4, :horizontal)).to be false
    end

    it 'returns false if ship overlaps another ship' do
      board.place_ship(ship, 0, 0, :horizontal)
      expect(board.valid_position?(ship, 0, 0, :horizontal)).to be false
    end
  end
end
