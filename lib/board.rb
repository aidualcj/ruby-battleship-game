class Board
  def initialize
    @grid = Array.new(5) { Array.new(5, '-') }
    @ships = []
  end

  def display
    @grid.each { |row| puts row.join(' ') }
  end

  def place_ship(ship, x, y, orientation)
    if position_valid?(ship, x, y, orientation)
      ship.calculate_coordinates(x, y, orientation)
      ship.coordinates.each do |coord|
        @grid[coord[0]][coord[1]] = 'S'
      end
      @ships << ship
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
      @grid[x][y] = 'X' # To mark as hit
      if ship_sunk_at?(x, y)
        'You sank a ship !'
      else
        'Hit !'
      end
    elsif @grid[x][y] == '-'
      @grid[x][y] = 'O' # To mark as miss
      'Miss...'
    else
      'Already shot here'
    end
  end

  def all_ships_sunk?
    @ships.all? do |ship|
      ship.coordinates.all? { |coord| @grid[coord[0]][coord[1]] == 'X' }
    end
  end

  def position_valid?(ship, x, y, orientation)
    ship.calculate_coordinates(x, y, orientation)
    ship.coordinates.all? do |coord|
      within_bounds?(coord[0], coord[1]) && @grid[coord[0]][coord[1]] == '-'
    end
  end

  private

  def within_bounds?(x, y)
    x.between?(0, 4) && y.between?(0, 4)
  end

  # New method to check if a specific ship is sunk
  def ship_sunk_at?(x, y)
    @ships.any? do |ship|
      if ship.coordinates.include?([x, y])
        # Check if all parts of this ship are hit ('X')
        all_sunk = ship.coordinates.all? { |coord| @grid[coord[0]][coord[1]] == 'X' }
        all_sunk
      end
    end
  end
end
