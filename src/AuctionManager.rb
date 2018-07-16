#!/usr/bin/ruy
load 'Item.rb'
load 'ItemSupplier.rb'

class AuctionManager
  def initialize()
    @counter = 0
    @supplier = ItemSupplier.new()
    @ItemCounter = Hash.new
    @players = nil
    @soldItemCount = 0
    @dumpedItemCount = 0
    @auctionCounter = 0
  end

  def Round
    @counter
  end

  def AuctionCount
    @auctionCounter
  end

  def SoldItemCount
    @soldItemCount
  end

  def WinnersPurchaseRatio
    self.WinnerItemCount.to_f/self.SoldItemCount.to_f * 100.0
  end

  def WinnerItemCount
    i = 0
    wp = self.WinnerPoint
    @players.each{|p|i = p.ItemCount if p.Point == wp}
    i 
  end

  def AverageRemainingBudget
    t = 0
    @players.each{|p|t += p.Budget}
    t.to_f/@players.count.to_f
  end 

  def WinnerPoint
    wp = -1
    @players.each{|p|wp = p.Point if p.Point > wp}
    wp
  end

  def LastItemKey
    @ItemCounter.each do |k,v|
      if v > 3
        return k
      end
    end
    return 0
  end

  def isGameEnded
    ended = false
    @ItemCounter.each do |k,v|
      if v > 3
        ended = true
      end
    end
    ended
  end

  def SetPlayers(ps)
    @players = ps
  end

  def PrintResult()
    @players.each{|p|p.Dump()}
    puts "Round:#{@counter} Auction:#{@auctionCounter} Sold:#{@soldItemCount} Dumped:#{@dumpedItemCount}"
  end
 
  def Proceed()
    @counter += 1
    i = GetItem()
    UpdateItemcunter(i)
    SetPlayerItem(i)
    ProceedAuction(i)
  end
  
  def SetPlayerItem(i)
    @players.each {|p| p.SetItem(i)}
  end

  def UpdateItemcunter(i)
    if @ItemCounter[i.Key] != nil
      @ItemCounter[i.Key] += 1
    else
      @ItemCounter[i.Key] = 1
    end
  end  

  def ProceedAuction(item)
    while item.RoundCounter < AUCTION_COUNT and item.Sold == false do
      #item.Dump()
      c = GetBiddingCount()
      if c > 0
        SellItemToHighestBidder(item)
      end
      item.IncrementCounter()
      @auctionCounter += 1
    end
    @soldItemCount += 1 if item.Sold
    @dumpedItemCount += 1 if not item.Sold
  end

  def SellItemToHighestBidder(item)
    p = GetHighestBidder()
    p.Purchase(item, p.BiddingPrice) 
    item.MarkAsSold()
  end
  
  def GetHighestBidder()
    price = -10
    player = nil
    @players.each{ |p|
      op = p.CalculateBiddingPrice()
      if op > price
        price = op
        player = p
      end  
    }
    player
  end

  def GetBiddingCount()
    c = 0
    @players.each{|p| c += 1 if p.Bidding}
    c
  end

  def GetItem()
    @supplier.GetItem()
  end
end
