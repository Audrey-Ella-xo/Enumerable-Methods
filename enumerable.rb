# frozen_string_literal: true
# rubocop:disable all
module Enumerable
  def my_each
    return to_enum unless block_given?
    i = 0
      while i < size
        yield self[i]
        i += 1
      end
  end

  def my_each_with_index
    return to_enum unless block_given?
    i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
  end

  def my_select
    return to_enum unless block_given?
    array2 = []
      i = 0
      while i < size
        array2 << self[i] if yield self[i]
        i += 1
      end
    array2
  end

  def my_all?(pattern = nil)
    test = true
    if(block_given?)
      self.my_each do |x|
        test = test && yield(x)
      end 
    else
      if(pattern.nil?)
        self.my_each do |x|
          test = test && (x==true)
        end
      else
        self.my_each do |x|
          test = test && (x.match?(pattern))
        end
      end
    end
    return test
  end

  def my_any?(pattern = nil)
    test = false
    if(block_given?)
      self.my_each do |x|
        test = test || yield(x)
      end
    else
      if(pattern.nil?)
        self.my_each do |x|
          test = test || (x == true)
        end
      else
        self.my_each do |x|
          test = test || (x.match?(pattern))
        end
      end
    end
    return test
  end

  def my_none?(pattern = nil)
    test = true
    if (block_given?)
      self.my_each do |x|
        test = test && !yield(x)
      end
    else
      if(pattern.nil?)
        self.my_each do |x|
          test = test && (x==false)
        end
      else
        self.my_each do |x|
          test = test && !x.match?(pattern)
        end
      end
    end
    return test
  end

  def my_count(arg = '')
    if block_given? == false && arg == ''
      length
    elsif block_given? == false
      count = 0
      i = 0
      while i < size
        count += 1 if self[i] == arg
        i += 1
      end
        count
    else
      count = 0
      i = 0
      while i < size
        count += 1 if yield self[i]
        i += 1
      end
      count
    end
  end
  
  # map that accepts both a block and a proc
  def my_map(&my_proc)
    return to_enum unless block_given?
    array3 = []
      i = 0
      while i < size
        array3 << if block_given?
                    yield(self[i])
                  else
                    my_proc.call(self[i])
                  end
        i += 1
      end
    array3
  end

  def my_inject(current = 0)
    i = 0
      accumulator = current
      while i < size
        accumulator = yield(accumulator, self[i])

        i += 1
      end
    accumulator
  end
end
# rubocop:enable all
def multiply_els(arr)
  arr.my_inject(1) { |i, j| i * j }
end

