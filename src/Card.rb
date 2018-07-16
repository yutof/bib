#!/usr/bin/ruby
class Card
  	def initialize(val)
		@value = val
  	end

  	def GetValue()
  		@value
  	end

	def ToString()
		"#{@value}"
	end

	def Dump()
		puts ToString()
	end
end

