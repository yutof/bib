#!/usr/bin/ruby
class Deck
  	def initialize()
		@deck = Array.new
  	end

	def Add(card)
		@deck << card
	end

	def Shuffle()
		@deck.shuffle!
	end 

	def Draw()
		@deck.pop
	end

	def IsEmpty()
		@deck.empty?
	end
	
	def IsNotEmpty()
		@deck.empty? == false
	end

	def Length()
		@deck.length
	end

	def GetDeckAverageValue()
    	total = 0.0
    	@deck.each { |c| total += c.GetValue()}
    	total/@deck.length		
	end

	def Dump()
		str = ""
		@deck.each { |c| str = str + "\n#{c.ToString()}"}
		puts str
	end
end

