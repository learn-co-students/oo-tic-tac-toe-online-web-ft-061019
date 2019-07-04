require 'pry'
class TicTacToe
  
   WIN_COMBINATIONS = [
    [0,1,2], #top 
    [3,4,5], #middle 
    [6,7,8], #bottom 
    [0,3,6], #left 
    [1,4,7], #middle 
    [2,5,8], #right 
    [0,4,8], #L-diag
    [2,4,6], #R-diag
  ]
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
 
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
 
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(string_int_move)
    string_int_move.to_i - 1
  end 
  
   def move(index, player = "X" )
    @board[index] = player
    end 
  
  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end
  
  def valid_move?(index)

  if index.between?(0,8) && !position_taken?(index)
      puts 'this is a valid move'
    return true
  else
   return false
  end
end
  
  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else 
      turn
    end 
  end 
  
  def play
    while !over?(board)
    turn(board)
  end 
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cat's Game!"
    end
  end 
end 


