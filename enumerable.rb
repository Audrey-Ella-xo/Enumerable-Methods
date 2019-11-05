module Enumerable
  def my_each
    i = 0
    while i < self.size
      yield self[i]
      i+=1
    end
    
  end

  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i)
      i+=1
    end
  end

  def my_select
    array2 = []
    i = 0
    while i < self.size
      if yield self[i]
      array2 << self[i]
      end
      i+=1
    end
    array2
  end
   
  def all?
    i = 0
    while i < self.size
      if yield self[i]
        return true
      end
      i+=1
    end
    
  end
end


array = [1,2,3,4,5]

p array.all?(String)