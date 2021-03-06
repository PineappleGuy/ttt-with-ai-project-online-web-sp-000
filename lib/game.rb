class Game

    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
       @player_1 = player_1
       @player_2 = player_2
       @board = board
    end

    def current_player
        if @board.turn_count.even? == true
            return player_1
        else 
            return player_2
        end
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
            pos1 = combo[0]
            pos2 = combo[1]
            pos3 = combo[2]
            if @board.cells[pos1] == @board.cells[pos2] && @board.cells[pos2] == @board.cells[pos3] && @board.cells[pos1] != " "
                return combo
            end
        end
        return false
    end

    def draw?
        if self.won? == false && @board.full? == true
            return true
        else
            return false
        end
    end

    def over?
        if won? || draw? == true
            return true
        else
            return false
        end
    end

    def winner
        if over? && won?
            return @board.cells[won?[0]]
        else
            return nil
        end
    end

    def turn
        current_player.move(@board)
    end

    def play
        while over? == false
            self.turn
        end
        if won?
            @board.display
            puts "Congratulations #{winner}!"
        else
            @board.display
            puts "Cat's Game!"
        end
    end

end