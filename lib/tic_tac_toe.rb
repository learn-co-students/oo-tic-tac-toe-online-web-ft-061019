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
   def initialize
      @board = Array.new(9, " ")
      @current_player = "X"
   end

   def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
   end

   def input_to_index(user_input_string)
      index = user_input_string.to_i - 1
   end

   #player arg is either "X" or "O"
   def move(indexed_input, player)
      @board[indexed_input] = player
   end
   
   def position_taken?(indexed_input)
      @board[indexed_input] == " " ? false : true
   end

   def valid_move?(indexed_input)
      valid_input_range = 0..8
      # Check to make sure the number that the user put in is in the valid index range of 0-8
      # if not, immediately put out false. if so, check to see if the position has been taken then put out true or false accordingly. 
      if valid_input_range.include?(indexed_input)
         self.position_taken?(indexed_input) == true ? false : true
      else
         false
      end
   end

   def turn_count
      count = @board.length - @board.count(" ")
   end

   def current_player
      #This program assumes that "X" always goes first. So if the number of "O"s is the same as "X"s that means that "O" has gone every turn that X has gone and it is X's turn otherwise it's O's turn.  
      x_turns = @board.count("X")
      o_turns = @board.count("O")

      if x_turns == o_turns
         @current_player = "X"
      else
         @current_player = "O"
      end
   end

   def turn
      valid = false 
      #This does the looping while trying to get a vaild user input.
      while valid == false
         user_input_string = gets.chomp
         indexed_input = input_to_index(user_input_string)
         valid = self.valid_move?(indexed_input)
         puts "Please enter 1-9"
      end

      #with a valid input from the user, go ahead and perform that move, and switch the current user to the other player
      self.move(indexed_input, @current_player)
      self.display_board
      self.current_player
   end

   def won?
      win_match_found = false

      #This iteration goes over the Win combinations constant array, and checks to see if the board has all of the same value at those winning combo locations.  
      # To do this I check the values_at the positions specified in the combo_arr which returns a array of strings at those locations in my @board.  To make compairing simpler, I convert this array of strings into a single string then compare the current @board string to see if it matches three Xs or three Os for the win.
      WIN_COMBINATIONS.map do |combo_arr|
         check = @board.values_at(combo_arr[0], combo_arr[1], combo_arr[2]).join

         if check == "XXX"
            win_match_found = combo_arr
            @winning_player = "X"
         elsif check == "OOO"
            win_match_found = combo_arr
            @winning_player = "O"
         end
      end

      win_match_found
   end

   def full?
      #if the entire @board array is full (i.e. no " " blanks left and if self.won? returns false, then we have a draw)
      status = false
      #though #won? will put out an array when it is true, an array is truthy and false is falsey.  
      # if this doesn't work, I may use nil instead of "false" in #won?
      if @board.include?(" ") != true && won? != true
         status = true
      end

      status
   end

   def draw?
      #if the result of won? is truthy (is an array) then set the status to false, else run the full? method to pass the other tests. 
      status = nil

      if !!won? == true
         status = false    
      else
         status = full?
      end
      status
   end

   def over?
      status = nil
      
      #if won? is truthy (returns an array) then the game is over, otherwise go with whatever the draw? method says. 
      if !!won? == true
         status = true
      else
         status = draw?
      end
      status
   end

   def winner
      #set a trigger variable of 'status'  if it is a draw, put out desired nil ouput, otherwise, put out who the winning player is.  
      status = nil
      draw? == true ? status : status = @winning_player
      status
   end

   def play
      #Welcome the player to the game and display the board.  Then run self.turn until over? method goes true
      puts "Welcome to Tic Tac Toe!"
      self.display_board
      puts "Please enter 1-9"
      while self.over? == false
         self.turn
      end

      #now check to see what type of ending we had -- if winner puts out something truthy (either "X" or "O") then congratulate that winner, otherwise, if it returns falsey (i.e. nil) then put out "Cat's Game!" aka a Draw. 
      if !!self.winner == true 
         puts "Congratulations #{self.winner}!" 
      else
         puts "Cat's Game!"
      end
   end

end