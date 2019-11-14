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

  def my_all
    return true if !block_given?

    i = 0
    while i < size
      return false if !yield(self[i])
      i += 1
    end

    return true
  end

  def my_any
    return true if !block_given?

    i = 0
    while i < size
      return true if yield(self[i])
      i += 1
    end

    return false
  end

  def my_none
    return true if !block_given?

    i = 0
    while i < size
      return false if yield(self[i])
      i += 1
    end

    return true
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

  def my_inject(x = nil)
    return nil if !block_given?

    if !x.nil?
      result = x
      i = 0
    else
      result = self[0]
      i = 1
    end

    while i < size
      result = yield(result, self[i])
      i += 1
    end

    return result
  end


end
# rubocop:enable all
def multiply_els(arr)
  arr.my_inject(1) { |i, j| i * j }
end
