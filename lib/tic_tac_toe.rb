class TicTacToe

  WIN_COMBINATIONS = [ 
  [0,1,2], 
  [3,4,5], 
  [6,7,8], 
  [0,3,6], 
  [1,4,7],  
  [2,5,8], 
  [0,4,8], 
  [6,4,2] 
  ]

  def initialize(board = nil)
      @board = board || Array.new(9, " ")
  end

  def display_board()
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
      user_input.to_i - 1
  end

  def move(index, player)
      @board[index] = player
  end

  def position_taken?(index)
      if (@board[index] == " ") || (@board[index] == "") || (@board[index] == nil)
         return false 
      else
         return true
      end
  end

  def valid_move?(index)
      if (index.between?(0,8) && @board[index]==" ")
          return true
      end
  end

  def turn
      puts "Please enter 1-9:"
      user_input = gets.strip
      index = input_to_index(user_input)
      if valid_move?(index)
         move(index, current_player)
         display_board()
      else
          turn()
      end
  end

  def turn_count
      counter = 0
      @board.each do |spaces|
         if spaces == "X" || spaces == "O"
            counter += 1
         end
      end
      counter
  end
   
  def current_player
    turns_played = turn_count()
    if turns_played % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
      WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]
      if @board[win_index_1] == "X" && @board[win_index_2] == "X" && @board[win_index_3] == "X"
      puts "Congratulations X!"
      puts "You won!"
      return win_combination
      elsif @board[win_index_1] == "O" && @board[win_index_2] == "O" && @board[win_index_3] == "O"
      puts "Congratulations O!"
      puts "You won!"
      return win_combination
          end
      end
      return false
  end 

  def full?
      @board.all? {|i| i == "X" || i == "O"}
  end

  def draw?
      won = won?()
      full = full?()
      if won == false && full == true
        return true
      elsif won == false && full == false
        return false
      end
  end

  def over?
    won = won?()
    draw = draw?()
    if draw == true || won != false
      return true
    else
      return false
    end
 end

  def winner
      won = won?()
      if won != false
        if @board[won[0]] == "X"
          return "X"
        elsif @board[won[0]] == "O"
          return "O"
      end
      else
        return nil
      end
  end

  def play
      until over?() == true
         puts "please enter 1-9: "
         turn()
      end 

      if draw?() == true
          puts "Cat's Game!"
      elsif won?() == true
          winner()
      end
  end

end
