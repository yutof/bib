#!/usr/bin/ruby
class Game
  def initialize(p, d, ps)
    @players = p
    @deck = d
    @board = GameBoard.new()
    @positionSelector = ps;
  end

  def IsGameEnded()
    false
  end

  def SelectCommunityCard()
      @deck.Draw()
  end

  def PlayRound()
      @board.SetCommunityCard(SelectCommunityCard())

      idx = 0
      @players.each {|p|
        pos = @positionSelector.SelectPosition()
        while @board.IsPositionAvailable(pos) == false do 
          pos = @positionSelector.SelectPosition()
        end
        @board.SetData(idx,p.Play, p, pos)
        idx += 1
      }
      @board.SelectSunValue()
      @board.AddRewardAndPenalty()
      @board.AddVictoryPoint()

  end

  def PlayGame()
      puts "todo"
  end

  def ToString()
    @board.ToString()
  end

  def Dump()
    puts ToString()
  end
end

