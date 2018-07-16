#!/usr/bin/ruby
class GameBoardPlayer
  def initialize()
  end

  def Card
    @Card
  end

  def Position
    @Position
  end

  def Player
    @Player
  end

  def SetData(crd, plyr, pos)
    @Card = crd
    @Player = plyr
    @Position = pos
  end

  def Reset()
  	@Card = nil
  	@Player = nil
    @Position = -1
  end
end

