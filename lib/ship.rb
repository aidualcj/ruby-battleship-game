class Ship
  attr_reader :size, :coordinates

  def initialize(size)
    @size = size
    @coordinates = []
  end

  # This method calculates and sets the coordinates when the ship is placed
  def calculate_coordinates(x, y, orientation)
    coords = []
    case orientation
    when :horizontal
      @size.times { |i| coords << [x, y + i] }
    when :vertical
      @size.times { |i| coords << [x + i, y] }
    end
    @coordinates = coords
  end
end
