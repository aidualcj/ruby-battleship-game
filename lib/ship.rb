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
    when :diagonal_right
      @size.times { |i| coords << [x + i, y + i] }
    when :diagonal_left
      @size.times { |i| coords << [x + i, y - i] }
    end
    @coordinates = coords
  end
end
