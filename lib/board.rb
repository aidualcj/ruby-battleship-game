class Board
  def initialize
    @grid = Array.new(5) { Array.new(5, '-') }
  end

  def display
    @grid.each { |row| puts row.join(' ') }
  end
end
