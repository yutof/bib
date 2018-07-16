#!/usr/bin/ruby
class Game
  def initialize(p, d, ps)
    @players = p
    @deck = d
    @board = GameBoard.new()
    @positionSelector = ps
    @totalRound = 0
  end

  def TotalRound
    @totalRound
  end

  def IsGameEnded()
      aliveCount = 0
      winnerCount = 0
      @players.each {|p|
        aliveCount += 1 if p.IsAlive()
        winnerCount += 1 if p.IsWinner()
      }
      winnerCount > 0 or aliveCount == 0
  end

  def SelectCommunityCard()
      @deck.Draw()
  end

  def PlayRound()
      @totalRound += 1
      @board.Reset()
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
      DrawCards()
  end

  def DrawCards()
      @players.each {|p|
          p.Draw(@deck.Draw())
      }
  end

  def PlayGame()

    while IsGameEnded() == false and @deck.IsEmpty() == false do
      PlayRound()
    end
    #puts "ゲーム終了時の残り枚数 #{@deck.Length()}"
  end

  def ToString()
    @board.ToString()
  end

  def Dump()
    puts ToString()
  end
end

