require 'board'

RSpec.describe Board do
  let(:board) { Board.new }

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
end
