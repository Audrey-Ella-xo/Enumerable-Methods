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

  # map with only a block given
  def my_map
    array3 = []
    i = 0
    while i < size
      array3 << yield(self[i])
      i += 1
    end
    array3
  end

  # map with only proc given
  def my_map_1(&procedure)
    array3 = []
    i = 0
    while i < size
      array3 << procedure.call(self[i])
      i += 1
    end
    array3
  end

  # map that accepts both a block and a proc
  def my_map_2(&my_proc)
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

  # def my_inject *initial
  #   memory = nil
  #       array = self.to_a
  #       if initial.size != 0
  #           memory = initial
  #       else
  #           memory = array[0]
  #           array.shift
  #       end
  #       array.length.times do |i|
  #           memory = yield(memory, array[i])
  #       end
  #       memory
  # end
end

def multiply_els(arr)
  arr.my_inject { |i, j| i * j }
end

p multiply_els([2, 4, 5])
