class Board
  def initialize
    @grid = Array.new(5) { Array.new(5, '-') }
  end

  def display
    @grid.each { |row| puts row.join(' ') }
  end

  def place_ship(ship, x, y, orientation)
    if valid_position?(ship, x, y, orientation)
      ship.coordinates(x, y, orientation).each do |coord|
        @grid[coord[0]][coord[1]] = 'S'
      end
    else
      raise "Invalid position for the ship"
    end
  end

  def valid_position?(ship, x, y, orientation)
    ship.coordinates(x, y, orientation).all? do |coord|
      within_bounds?(coord[0], coord[1]) && @grid[coord[0]][coord[1]] == '-'
    end
  end

  private

  def within_bounds?(x, y)
    x.between?(0, 4) && y.between?(0, 4)
  end
end
