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

  def my_all?(type = nil)
    ary = []
    has = {}
    if block_given?
        if self.is_a?(Array)
            self.my_each { |n| yield(n) == true ? ary.push(true) : false }
            self.length == ary.length ? (puts "true") : (puts "false")
            ary
        else
            self.my_each { |k, v| yield(k, v) == true ? has[k] = v : (puts "hash") }
            has
        end
    
    elsif type != nil
        self.my_each { |n| n.is_a?(type) ? ary.push(true) : false }
        self.length == ary.length ? (puts "true") : (puts "false")
    
    else
        self.my_each { |n| n != false && n != nil ? ary.push(true) : false }
        self.length == ary.length ? (puts "true") : (puts "false")
    end
  end

  def my_any?(type = nil)
    ary = []
    has = {}
    if block_given?
        if self.is_a?(Array)
            self.my_each { |n| yield(n) == true ? ary.push(true) : false }
            ary.length >= 1 ? (puts "true") : (puts "false")
            ary
        else
            self.my_each { |k, v| yield(k, v) == true ? has[k] = v : false }
            has.length >= 1 ? (puts "true") : (puts "false")
            has
        end
    
    elsif type != nil
        self.my_each { |n| n.is_a?(type) ? ary.push(true) : false }
        self.length == ary.length ? (puts "true") : (puts "false")
    
    else
        self.my_each { |n| n != false && n != nil ? ary.push(true) : false }
        ary.length >= 1 ? (puts "true") : (puts "false")
    end
  end

  def my_none?(type = nil)
    ary = []
    has = {}
    if block_given?
        if self.is_a?(Array)
            self.my_each { |n| yield(n) == true ? ary.push(true) : false }
            ary.length >= 1 ? (puts "false") : (puts "true")
            ary
        else
            self.my_each { |k, v| yield(k, v) == true ? has[k] = v : false }
            has.length >= 1 ? (puts "false") : (puts "true")
            has
        end
    
    elsif type != nil
        self.my_each { |n| n.is_a?(type) ? ary.push(true) : false }
        self.length == ary.length ? (puts "false") : (puts "true")
    
    else
        self.my_each { |n| n != false && n != nil ? ary.push(true) : false }
        ary == nil ? (puts "true") : (puts "false")
        ary
    end
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

  def my_inject(val = nil, sym = nil)
    result = self[0]
    if val.is_a?(String) || val.is_a?(Symbol)
        sym = val
        val = nil
    end
    if val.is_a?(Integer)
        result = val
    end
    if sym.nil?
        if block_given?
            if val == nil
                drop(1).my_each { |i| result = yield(result, i) }
            else
                result = val
                my_each { |i| result = yield(result, i) }
            end
        end
    else
        if sym == :* || sym == :/
            if val == nil
                drop(1).my_each { |i| result = result.send(sym, i) }
            else
                result = val
                my_each { |i| result = result.send(sym, i) }     
            end
        else
            if val != nil
                my_each { |i| result = result.send(sym, i) }
            else
                drop(1).my_each { |i| result = result.send(sym, i) }
            end
        end
    end
    return result
  end

end
# rubocop:enable all
def multiply_els(arr)
  arr.my_inject(1) { |i, j| i * j }
end
