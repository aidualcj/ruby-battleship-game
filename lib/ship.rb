class Ship
  attr_reader :size

  def initialize(size)
    @size = size
  end

  def coordinates(x, y, orientation)
    coords = []
    case orientation
    when :horizontal
      @size.times { |i| coords << [x, y + i] }
    when :vertical
      @size.times { |i| coords << [x + i, y] }
    end
    coords
  end
end
