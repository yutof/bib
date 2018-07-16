#!/usr/bin/ruy
load 'Request.rb'

class RequestGenerator

  def initialize()
    @requests = GenerateRequests()
  end 

  def GenerateRequests()
    arr = Array.new 
    for i in 1..(CARD_REQUEST_DICT.keys.count)
      v = CARD_REQUEST_DICT["#{i}"]
      for j in 0..(v.count-1)
        for k in 1..v[j]
          arr.push(Request.new(i,j+1))
        end 
      end
    end
    arr.shuffle
  end

  def Generate()
    @requests.pop()
  end
end
