class Player
  attr_reader :name, :board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    [Ship.new(3), Ship.new(4)].each do |ship|
      loop do
        puts "#{name}, where do you want to place your #{ship.size}-unit ship? (format: x y orientation)"
        x, y, orientation = gets.chomp.split
        x, y = x.to_i, y.to_i
        if @board.valid_position?(ship, x, y, orientation.to_sym)
          @board.place_ship(ship, x, y, orientation.to_sym)
          @board.display
          break
        else
          puts "Invalid position for the ship, please try again."
        end
      end
    end
  end
end
