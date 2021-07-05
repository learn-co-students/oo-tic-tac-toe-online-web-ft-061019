require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [ 
        [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]  
    ]

    def initialize
        @board = [" ", " ", " ", " ", " "," ", " ", " ", " "]
    end 

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        index = string.to_i - 1
     end

    def move(index, token = "X")
        @board[index] = token 
    end 

    def position_taken?(index)
        if (@board[index] == " " || @board[index] == nil) 
            return false 
        else 
            return true 
        end 
    end 

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index) 
    end 

    def turn 
        "Please choose a space to place your token!"
        choice = gets.strip 
        index = input_to_index(choice)
        x_o = current_player
        if valid_move?(index)
            move(index, x_o)
            display_board
        else
            turn
        end
    end 

    def turn_count 
        turns = 0 
        @board.each do |place|
            if place == "X" || place == "O"
                turns += 1
            end 
        end 
        turns 
    end 

    def current_player
        if turn_count % 2 === 0 
            "X"
        else 
            "O"
        end 
    end 

    def won?
        WIN_COMBINATIONS.each {|winning_moves|
            position_1 = @board[winning_moves[0]]
            position_2 = @board[winning_moves[1]]
            position_3 = @board[winning_moves[2]]
            
            if position_1 == "X" && position_2 == "X" && position_3 == "X" 
                return winning_moves
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
                return winning_moves
            end
        }
         return false 
    end 
           
    def full? 
        @board.all? {|index| index == "X"||index == "O"}
    end 
           
    def draw?
        if !won? && full?
            true 
        else
            false
        end 
    end 

    def over?
        draw? || won?
    end 
           
    def winner
        winning_moves = won?
        if winning_moves 
            return @board[winning_moves[0]]
        end 
    end 
           
    def play
        while !over?
          turn
        end
    
        if won?
          puts "Congratulations #{winner}!"    
        elsif draw?
          puts "Cat's Game!"
        end
      end


end 
