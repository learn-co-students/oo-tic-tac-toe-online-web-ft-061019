require "pry"

class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        
        [0, 4, 8],
        [6, 4, 2]
    ]

    def initialize 
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        index = input.to_i - 1
        @board[index] = index
    end

    def move (index, token = 'X')
        @board[index] = token
    end

    def position_taken? (index)
        if @board[index.to_i] == 'X'
            return true
        elsif @board[index.to_i] == 'O'
            return true
        else
            return false
        end
    end
        
    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
        count = 0
        @board.each do |spot|
            if spot == 'X'
                count += 1
            elsif spot == 'O'
                count += 1
            end
        end
        count
    end

    def current_player
        if turn_count % 2 == 0
            return 'X'
        else
            return 'O'
        end

    end

    def turn
        status = false 
        while status == false
            puts "Please enter 1-9:"
            input = gets.chomp
            index = input_to_index(input)
            if valid_move?(index)
                    status = true
            end
        end
        move(index, current_player)
        display_board
    end

    def won?
        WIN_COMBINATIONS.each do |win_combo|
            if (@board[win_combo[0]] == "X" && 
                @board[win_combo[1]] == "X" && 
                @board[win_combo[2]] == "X") || 
                (@board[win_combo[0]] == "O" && 
                @board[win_combo[1]] == "O" && 
                @board[win_combo[2]] == "O")
                    return win_combo
            end
        end
        return false
    end

    def full?
        @board.all? {|token| token != " "}
    end

    def draw?
        if full? && !won?
            true
        else 
            false
        end
    end

    def over?
        if draw? || won?
            true
        end
    end

    def winner
        WIN_COMBINATIONS.detect do |win_combo|
            if (@board[win_combo[0]]) == "X" && 
                (@board[win_combo[1]]) == "X" && 
                (@board[win_combo[2]]) == "X"
                    return "X"
            elsif (@board[win_combo[0]]) == "O" && 
                (@board[win_combo[1]]) == "O" && 
                (@board[win_combo[2]]) == "O"
                    return "O"
            else
                nil
            end
        end
    end

    def play
        until over? do
            turn
        end
        if draw?
            puts "Cat's Game!"
        end
        if winner = "X"
            puts "Congratulations X!"
        end
        if winner = "O"
            puts "Congratulations O!"
        end
        
    end

end
