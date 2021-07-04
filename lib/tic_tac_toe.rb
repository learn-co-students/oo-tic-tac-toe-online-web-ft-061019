class TicTacToe
    # attr_accessor :board
    attr_reader :board
    # defines a constant WIN_COMBINATIONS with arrays for each win combination
    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],]

    def initialize(board=nil)
        # assigns an instance variable @board to an array with 9 blank spaces " "
        @board ||= Array.new(9, " ")
        
    end

    def display_board
        # prints arbitrary arrangements of the board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end

    def input_to_index(user_input)
        # accepts the user's input (a string) as an argument
        # converts the user's input (a string) into an integer
        # converts the user's input from the user-friendly format (on a 1-9 scale) 
        # to the array-friendly format (where the first index starts at 0)
        user_input.to_i - 1 
    end

    def move(user_input, token="X")
        # allows "X" player in the top left and "O" in the middle
        board[user_input] = token
    end
    def position_taken?(index)
        # returns true/false based on whether the position on the board is already occupied
        board[index] == "O" || board[index] == "X"
    end
    def valid_move?(position)
        # returns true/false based on whether the position is already occupied
        # checks that the attempted move is within the bounds of the game board
        position > board.length || position < 0 ? false : position_taken?(position) ? false : true 
    end

    def turn_count
    # counts occupied positions
        @board.count {|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end
    
    def turn
        get_input = true
        while get_input
            # 1. Ask the user for their move by specifying a position between 1-9.
            puts "Enter a move 1-9"
            # 2. Receive the user's input.
            user_move = input_to_index(gets.chomp)
            # 3. Translate that input into an index value.
            # 4. If the move is valid, make the move and display the board.
            if valid_move?(user_move)
                move(user_move, current_player)
                display_board
                # Get user out of the loop
                get_input = false
            else
                # 5. If the move is invalid, ask for a new move until a valid move is received.
                # User still in the loop
                puts "Move is not valid"
            end
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|
        if (@board[combo[0]]) == "X" && (@board[combo[1]]) == "X" && (@board[combo[2]]) == "X"
            return combo
        elsif (@board[combo[0]]) == "O" && (@board[combo[1]]) == "O" && (@board[combo[2]]) == "O"
            return combo
        end
            false
        end
    end
    
    def full?
        @board.all?{|content| content != " "}
    end

    def draw?
        !(won?) && (full?)
    end

    def over?
        won? || full? || draw?
    end

    def winner
        WIN_COMBINATIONS.detect do |combo|
          if (@board[combo[0]]) == "X" && (@board[combo[1]]) == "X" && (@board[combo[2]]) == "X"
            return "X"
          elsif (@board[combo[0]]) == "O" && (@board[combo[1]]) == "O" && (@board[combo[2]]) == "O"
            return "O"
          else
            nil
          end
        end
    end
    
    def play
        while over? == false
          turn
        end
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end
end
