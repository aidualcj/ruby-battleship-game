class Player
  attr_reader :name, :board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    [Ship.new(3), Ship.new(4)].each do |ship|
      loop do
        puts "#{name}, where do you want to place your #{ship.size}-unit ship? Format: x y orientation (e.g., '0 0 horizontal')"
        input = gets.chomp.split

        # Validate input format: x y orientation
        if input.size != 3 || !valid_coordinate_format?(input[0], input[1]) || !%w[horizontal vertical].include?(input[2])
          puts "Invalid input, must be two numbers between 0 and 4, separated by a space, followed by 'horizontal' or 'vertical'."
          next
        end

        x, y = input[0].to_i, input[1].to_i
        orientation = input[2]

        # Validate coordinates range for ship placement
        unless x.between?(0, 4) && y.between?(0, 4)
          puts "Invalid input, must be two numbers between 0 and 4, separated by a space, followed by 'horizontal' or 'vertical'."
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

  def take_turn(opponent_board)
    loop do
      puts "#{name}, choose coordinates to shoot (e.g., 0 0):"
      input = gets.chomp.split

      # Validate input format: x y
      if input.size != 2 || !valid_coordinate_format?(input[0], input[1])
        puts "Invalid input, must be two numbers between 0 and 4, separated by a space."
        next
      end

      x, y = input[0].to_i, input[1].to_i

      # Validate if within bounds for shooting
      unless x.between?(0, 4) && y.between?(0, 4)
        puts "Shot out of bounds, try again."
        next
      end

      result = opponent_board.shoot(x, y)
      puts result

      break unless result == 'Out of bounds'
    end
  end

  # Method to validate if input format is numeric and within bounds
  def valid_coordinate_format?(x, y)
    x.match?(/^\d$/) && y.match?(/^\d$/)
  end
end
