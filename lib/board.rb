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

  def shoot(x, y)
    if !within_bounds?(x, y)
      puts "Shot out of bounds, try again."
      return 'Out of bounds'
    end

    if @grid[x][y] == 'S'
      @grid[x][y] = 'X' # Mark as hit
      if ship_sunk?(x, y)
        'Sink'
      else
        'Hit'
      end
    elsif @grid[x][y] == '-'
      @grid[x][y] = 'O' # Mark as miss
      'Miss'
    else
      'Already shot here'
    end
  end

  def all_ships_sunk?
    @grid.flatten.none? { |cell| cell == 'S' }
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

  def ship_sunk?(x, y)
    # Iterate through the board to check if there is any remaining 'S' of a ship
    @grid.flatten.none? { |cell| cell == 'S' }
  end
end
