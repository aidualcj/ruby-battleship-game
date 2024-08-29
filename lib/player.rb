class Player
  attr_reader :name, :board

  def initialize(name)
    @name = name
    @board = Board.new
    @consecutive_misses = 0
  end

  def place_ships
    [Ship.new(3), Ship.new(4)].each do |ship|
      loop do
        puts "#{name}, where do you want to place your #{ship.size}-unit ship? Format: x y orientation (e.g., '0 0 horizontal')"
        input = gets.chomp.split

        if input.size != 3 || !valid_coordinate_format?(input[0], input[1]) || !%w[horizontal vertical diagonal_right diagonal_left].include?(input[2])
          puts "Invalid input, must be two numbers between 0 and 4, separated by a space, followed by 'horizontal', 'vertical', 'diagonal_right', or 'diagonal_left'."
          next
        end

        x, y = input[0].to_i, input[1].to_i
        orientation = input[2]

        unless x.between?(0, 4) && y.between?(0, 4)
          puts "Ship out of bounds, please try again."
          next
        end

        valid, error_message = @board.position_valid?(ship, x, y, orientation.to_sym)
        if valid
          @board.place_ship(ship, x, y, orientation.to_sym)
          @board.display
          break
        else
          puts error_message
        end
      end
    end
  end

  def take_turn(opponent_board)
    loop do
      puts "#{name}, choose coordinates to shoot (e.g., 0 0):"
      input = gets.chomp.split

      if input.size != 2 || !valid_coordinate_format?(input[0], input[1])
        puts "Invalid input, must be two numbers between 0 and 4, separated by a space."
        next
      end

      x, y = input[0].to_i, input[1].to_i

      unless x.between?(0, 4) && y.between?(0, 4)
        puts "Shot out of bounds, try again."
        next
      end

      result = opponent_board.shoot(x, y)
      puts result

      if result == 'Miss...'
        @consecutive_misses += 1
        if @consecutive_misses == 3
          give_hint(opponent_board)
          @consecutive_misses = 0
        end
      else
        @consecutive_misses = 0
      end

      break unless result == 'Out of bounds'
    end
  end

  def give_hint(opponent_board)
    valid_shots = []
    (0..4).each do |x|
      (0..4).each do |y|
        valid_shots << [x, y] if opponent_board.within_bounds?(x, y) && opponent_board.instance_variable_get(:@grid)[x][y] == 'S'
      end
    end

    hint = valid_shots.sample
    puts "Hint: Try shooting at #{hint[0]} #{hint[1]}"
  end

  def valid_coordinate_format?(x, y)
    x.match?(/^\d$/) && y.match?(/^\d$/)
  end
end
