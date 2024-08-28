require 'ship'

RSpec.describe Ship do
  let(:ship) { Ship.new(3) }

  describe '#initialize' do
    it 'sets the size of the ship' do
      expect(ship.size).to eq(3)
    end
  end

  describe '#coordinates' do
    it 'returns correct coordinates for horizontal orientation' do
      expect(ship.coordinates(0, 0, :horizontal)).to eq([[0, 0], [0, 1], [0, 2]])
    end

    it 'returns correct coordinates for vertical orientation' do
      expect(ship.coordinates(0, 0, :vertical)).to eq([[0, 0], [1, 0], [2, 0]])
    end
  end
end
