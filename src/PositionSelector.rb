#!/usr/bin/ruby
class PositionSelector
  	def initialize()
  		@rand = Random.new
  	end

  	def SelectPosition()
  		@rand.rand(NUMBER_OF_AREAS)
  	end  	
end

