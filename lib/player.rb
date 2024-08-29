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

        # Validate numeric coordinates
        if !valid_coordinate?(x) || !valid_coordinate?(y)
          puts "Invalid input, coordinates must be numbers between 0 and 4."
          next
        end

        x, y = x.to_i, y.to_i

        # Validate coordinates range
        unless x.between?(0, 4) && y.between?(0, 4)
          puts "Invalid position for the ship, coordinates must be between 0 and 4."
          next
        end

        # Validate orientation
        unless %w[horizontal vertical].include?(orientation)
          puts "Invalid orientation, please enter 'horizontal' or 'vertical'."
          next
        end

        # Validate ship placement
        if @board.position_valid?(ship, x, y, orientation.to_sym)
          @board.place_ship(ship, x, y, orientation.to_sym)
          @board.display
          break
        else
          puts "Invalid position for the ship, please try again."
        end
      end
    end
  end

  def valid_coordinate?(coord)
    coord.match?(/^\d+$/) && coord.to_i.between?(0, 4)
  end

  def take_turn(opponent_board)
    loop do
      puts "#{name}, choose coordinates to shoot (e.g., 0 0):"
      x, y = gets.chomp.split

      # Validate numeric coordinates
      if !valid_coordinate?(x) || !valid_coordinate?(y)
        puts "Invalid input, coordinates must be numbers between 0 and 4."
        next
      end

      x, y = x.to_i, y.to_i

      if !x.between?(0, 4) || !y.between?(0, 4)
        puts "Shot out of bounds, try again."
        next
      end

      result = opponent_board.shoot(x, y)
      puts result

      break unless result == 'Out of bounds'
    end
  end
end
