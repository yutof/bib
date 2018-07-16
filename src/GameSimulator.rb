#!/usr/bin/ruby
load 'Config.rb'
load 'Deck.rb'
load 'Card.rb'
load 'Player.rb'
load 'Game.rb'
load 'GameBoard.rb'
load 'GameBoardPlayer.rb'
load 'PositionSelector.rb'




def puts(o)
  if PRINT_ENABLED
    super(o)
  end 
end

def InitVars()
	@Deck = Deck.new()
	@Players = Array.new()
	ConstructDeck()
	@Deck.Shuffle()
	SetupPlayers()
end

def ConstructDeck()
	for i in 1..MAX_CARD_NUMER
		@Deck.Add(Card.new(i))		
	end
end

def SetupPlayers()
	for i in 1..NUM_OF_PLAYERS
		p = Player.new(i)
		for j in MINIMUM_CARD_NUMER..INITIAL_CARD_NUM
		  p.Draw(@Deck.Draw())
		end
		@Players << p
	end
end

def Simulate(n)
	for i in 1..n
		InitVars()
		game = Game.new(@Players, @Deck, @positionSelector)
		game.PlayGame()
		#game.Dump()
		@totalRound += game.TotalRound
		@remainingCards += @Deck.Length()
	end
end


@totalRound = 0
@remainingCards = 0

start = Time.now
puts "Start the game!"
@positionSelector = PositionSelector.new()
Simulate(SIMULATE_N_TIMES)
puts "Average round : #{@totalRound * 1.0 / SIMULATE_N_TIMES}"
puts "Average remaining cards : #{@remainingCards * 1.0 / SIMULATE_N_TIMES}"

finish = Time.now
diff = finish - start
puts "Ended. Took #{diff}"
