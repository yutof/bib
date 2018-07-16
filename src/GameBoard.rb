#!/usr/bin/ruby
load 'GameBoardPlayer.rb'

class GameBoard
  	def initialize()
  		InitializePlayerData()
  		@position = {}
  		Reset()
  	end

  	def InitializePlayerData()
  		@playerData = Array.new()
  		for i in 1..NUM_OF_PLAYERS
  			@playerData << GameBoardPlayer.new()
  		end
  	end

  	def SetCommunityCard(c)
  		@communityCard = c
  	end

  	def IsPositionAvailable(pos)
  		AREA_AVAILABILITY[pos] - @position[pos] > 0
  	end

  	def SetData(index, card, player, position)
  		@playerData[index].SetData(card, player, position)
  		@position[position] += 1
  	end

  	def SelectSunValue()
  		values = Array.new()
  		@playerData.each {|p|values << p.Card.GetValue()}
  		values << @communityCard.GetValue() if @playerData.length % 2 == 0
  		if AreAllValuesGreaterThanCommunityCard(values)
  			@sunValue = values.sort()[values.length - 1]#最大値
  		elsif AreAllValuesSmallerThanCommunityCard(values)
  		 	@sunValue = values.sort()[0]#最小値
  		else 
  			@sunValue = values.sort()[2]#中央値 
  		end
  	end

  	def AreAllValuesGreaterThanCommunityCard(values)
  		allGreater = true
  		values.each {|v| allGreater = false if v < @communityCard.GetValue()}
  		allGreater
  	end

  	def AreAllValuesSmallerThanCommunityCard(values)
  		allSmaller = true
  		values.each {|v| allSmaller = false if v > @communityCard.GetValue()}
  		allSmaller
  	end

  	def AddRewardAndPenalty()
  		@playerData.each {|p|
  			value = AREA_CONFIZG[p.Position]
  			if @sunValue >= value
  				AddReward(p)
  			else
  				AddPenalty(p)
  			end
  		}
  	end

  	def AddReward(p)
  		p.Player.AddSeeds(REWARDS[p.Position])
  	end

  	def AddPenalty(p)
  		p.Player.AddPenalties(PENALTIES[p.Position])
  	end

  	def AddVictoryPoint()
  		winnerPosition = GetWinnerPosition()
  		@playerData.each {|p|
  			if p.Position == winnerPosition
  				p.Player.BloomFlower()
  			end
  		}
  	end

  	def GetWinnerPosition()
  		mostDangerousPosition = 100
  		@playerData.each {|p|
  			value = AREA_CONFIZG[p.Position]
  			if @sunValue >= value and mostDangerousPosition > p.Position
  				mostDangerousPosition = p.Position
  			end
  		}
  		mostDangerousPosition
  	end

  	def Reset()
  		for i in 1..NUMBER_OF_AREAS
  			@position[i-1] = 0
  		end
  		@playerData.each {|p|p.Reset()}
  	end

	def ToString()
		str = ""
		@playerData.each {|p|str += p.Player.ToString() + "\n"}
		str + "\n"
	end

	def Dump()
		puts ToString()
	end
end

