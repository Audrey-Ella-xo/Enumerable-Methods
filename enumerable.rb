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

  def my_all?(arg = nil)
    if block_given?
      my_each { |element| return false unless yield(element) }
    elsif arg.is_a? Regexp
      my_each { |element| return false unless arg =~ element }
    elsif arg.is_a? Class
      my_each { |element| return false unless element.class == arg }
    else
      my_each { |element| return false unless element }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |element| return true if yield(element) }
    elsif arg.is_a? Regexp
      my_each { |element| return true if arg =~ element }
    elsif arg.is_a? Class
      my_each { |element| return true if element.class == arg }
    else
      my_each { |element| return true if element }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |element| return false if yield(element) }
    elsif arg.is_a? Regexp
      my_each { |element| return false if arg =~ element }
    elsif arg.is_a? Class
      my_each { |element| return false if element.class == arg }
    else
      my_each { |element| return false if element }
    end
    true
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

  def my_inject(init = nil, arg = nil)
    result = self[0]
    if block_given?
      my_each_with_index do |element, i|
        result = yield(result, element) unless i.zero?
      end
    else
      my_each_with_index do |element, i|
        sym = init.is_a?(Symbol) ? init : arg
        result = result.send(sym, element) unless i.zero?
      end
    end
    result
  end


end
# rubocop:enable all
def multiply_els(arr)
  arr.my_inject(1) { |i, j| i * j }
end
