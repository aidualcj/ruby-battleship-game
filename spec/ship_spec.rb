require 'ship'

RSpec.describe Ship do
  let(:ship) { Ship.new(3) }

  describe '#calculate_coordinates' do
    it 'returns correct coordinates for horizontal orientation' do
      ship.calculate_coordinates(0, 0, :horizontal)
      expect(ship.coordinates).to eq([[0, 0], [0, 1], [0, 2]])
    end

    it 'returns correct coordinates for vertical orientation' do
      ship.calculate_coordinates(0, 0, :vertical)
      expect(ship.coordinates).to eq([[0, 0], [1, 0], [2, 0]])
    end

    it 'returns correct coordinates for diagonal right orientation' do
      ship.calculate_coordinates(0, 0, :diagonal_right)
      expect(ship.coordinates).to eq([[0, 0], [1, 1], [2, 2]])
    end

    it 'returns correct coordinates for diagonal left orientation' do
      ship.calculate_coordinates(0, 2, :diagonal_left)
      expect(ship.coordinates).to eq([[0, 2], [1, 1], [2, 0]])
    end
  end
end
