#!/usr/bin/ruy

class Player
  def initialize(i)
    @id = i
    @cards = Array.new()
    @seedsCount = INITIAL_SEEDS
    @vp = 0
  end

  def Draw(card)
    @cards << card
  end

  def Play()
    @cards.pop
  end

  def IsAlive()
    @seedsCount > 0 or @cards.length > 0
  end

  def IsWinner()
    @vp >= GAME_WINNER_VP
  end


  def AddSeeds(s)
    @seedsCount += s  
  end

  def BloomFlower()
    if @seedsCount >= SEED_TO_FLOWER_RATE
      @seedsCount -= SEED_TO_FLOWER_RATE
      @vp += 1
    end
  end


  def AddPenalties(p)
    for i in 1..p
      AddPenalty()
    end
  end

  def AddPenalty()
    if @seedsCount > 0
      @seedsCount -= 1
    else
      @cards.pop
    end
  end 

  def PrintAllCards()
    str = ""
    @cards.each { |c| str = str + "\n#{c.ToString()}"}
    puts "My Cards \n#{str}\n"
  end

  def GetAverageValue()
    total = 0.0
    @cards.each { |c| total += c.GetValue()}
    total/@cards.length
  end

  def GetCardsCount
    @cards.length
  end

  def ToString()
    "Player(#{@id})  vp:#{@vp} seed:#{@seedsCount}  card #{@cards.length}"
  end

  def Dump()
    puts ToString()
  end

end
