# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < size
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    array2 = []
    i = 0
    while i < size
      array2 << self[i] if yield self[i]
      i += 1
    end
    array2
  end

  def all?
    i = 0
    while i < size
      return false unless yield self[i]

      i += 1
    end
  end

  def any?
    i = 0
    while i < size
      return true if yield self[i]

      i += 1
    end
  end

  def none?
    i = 0
    while i < size
      return false if yield self[i]

      i += 1
    end
  end

  def my_count(*arg)
    if block_given? == false && arg == ''
      length
    elsif block_given? == false
      count = 0
      i = 0
      while i < size
        count += 1 if self[i] == arg
        i += 1
      end
    else
      count = 0
      i = 0
      while i < size
        count += 1 if yield self[i]
        i += 1
      end
    end
  end

  def my_map
    array3 = []
    i = 0
    while i < size
      yield self[i]
      array3 << self[i]
      i += 1
    end
    array3
  end
end

array = [1, 2, 3, 4, 5, 5, 7, 8, 9, 10]

p array.count(5) #=> [1, 4, 9, 16]
# (1..4).collect { "cat"  }
