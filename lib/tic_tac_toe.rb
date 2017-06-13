class TicTacToe
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end
  WIN_COMBINATIONS = [
    [0, 1, 2], #top horiz
    [3, 4, 5], #middle horiz
    [6, 7, 8], #bottom horiz
    [0, 3, 6], #left vert
    [1, 4, 7], #middle vert
    [2, 5, 8], #right vert
    [0, 4, 8], #l-r diag
    [2, 4, 6] #r-l diag
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    int = input.to_i
    @index = int - 1
  end

  def move(index, character = "X")
    @board[index] = character
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      false
    else
      true
    end
  end

  def valid_move?(index)
    if index.between?(0, 8) && position_taken?(index) == false
      true
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    player = current_player
    valid = valid_move?(index)
    if valid == true
      move(index, player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count = 0
    @board.each do |index|
      if index == "X" || index == "O"
        count += 1
      end
    end
    return count
  end

  def current_player
    turn = turn_count
    turn.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |condition|
       if condition.all?{|position| position_taken?(position) == true}
         if (@board[condition[0]] == "X" && @board[condition[1]]=="X" && @board[condition[2]]=="X")
           return condition
         elsif (@board[condition[0]] == "O" && @board[condition[1]]=="O" && @board[condition[2]]=="O")
           return condition
         end
       end
    end
    false
  end

  def full?
    @board.all? do |position|
      position == "X" || position == "O"
    end
  end

  def draw?
    if won? == false && full? == true
      true
    end
  end

  def over?
    if won? != false || full? == true
      true
    end
  end

  def winner
    if over? == true && draw? != true
      player = @board[won?[0]]
    end
  end

  def play
    if over? != true
      turn
      if draw? != true
        play
      end
    else
      if won? != false
        if winner == "X"
          puts "Congratulations X!"
        else
          puts "Congratulations O!"
        end
      else
        puts "Cat's Game!"
      end
    end
  end

end
