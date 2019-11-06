# frozen_string_literal: true

module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < size
        yield self[i]
        i += 1
      end      
    else
      p "No block given!"
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
    else
      p "No block given!"
    end
  end

  def my_select
    if block_given?
      array2 = []
      i = 0
      while i < size
        array2 << self[i] if yield self[i]
        i += 1
      end
    else
      p "No block given!"
    end
    array2
  end

  def my_all?
    if block_given?
      i = 0
      while i < size
        return false unless yield self[i]

        i += 1
      end
    else
      p 'No block given!'
    end
    true
  end

  def my_any?
    if block_given?
      i = 0
    while i < size
      return true if yield self[i]

      i += 1
    end
    else
      p "No block given!"
    end
    false
  end

  def my_none?
    i = 0
    while i < size
      return false if yield self[i]

      i += 1
    end
    true
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

print "-------------------"
puts "\n"
puts "Start tests"
puts "\n"
print "-------odin inject test---------"
puts "\n"
p multiply_els([2, 4, 5])
puts "\n"
print "-------------------"
puts "\n"
print "-----Start enumerable tests------"
puts "\n"
print "-------my_each---------"
puts "\n"
[5,3,7,300,800].my_each{|x| p x}
puts "\n"
print "-------------------"
puts "\n"
print "-------my_each_with_index---------"
puts "\n"
[5,3,7,300,800].my_each_with_index{|x,y| p "#{x} => #{y}"}
puts "\n"
print "-------------------"
puts "\n"
print "-------my_select---------"
puts "\n"
p [1,2,3,4,5].my_select { |num|  num.even?  } 
p [:foo, :bar].my_select { |x| x == :foo }   
puts "\n"
print "-------------------"
puts "\n"
print "-------my_all?---------"
puts "\n"
p %w[ant bear cat].my_all? { |word| word.length >= 3 } 
p %w[ant bear cat].my_all? { |word| word.length >= 4 } 
puts "\n"
print "-------------------"
puts "\n"
print "-------my_any?---------"
puts "\n"
p %w[ant bear cat].my_any? { |word| word.length >= 3 } 
p %w[ant bear cat].my_any? { |word| word.length >= 4 } 
puts "\n"
print "-------------------"
puts "\n"
print "-------my_none?---------"
puts "\n"
p %w{ant bear cat}.my_none? { |word| word.length == 5 } 
p %w{ant bear cat}.my_none? { |word| word.length >= 4 }
puts "\n"
print "-------------------"
puts "\n"
print "-------my_count---------"
puts "\n"
ary = [1, 2, 4, 2]
p ary.count               
p ary.count(2)            
p ary.count{ |x| x%2==0 } 
puts "\n"
print "-------------------"
puts "\n"
print "-------my_map methods---------"
puts "\n"
print "-------my_map with block---------"
puts "\n"
p [1,2,3,4].my_map { |i| i*i }      
p [1,2,3,4].my_map { "cat"  }   
puts "\n"
print "-------------------"
print "-------my_map with proc---------"
puts "\n"
my_proc = Proc.new{ |i| i*i }
my_proce = Proc.new{ "cat"  }
p [1,2,3,4].my_map_1(&my_proc)     
p [1,2,3,4].my_map_1(&my_proce)    
puts "\n"
print "-------------------"
print "-------my_map with proc or block---------"
puts "\n"
bloc = Proc.new{ "cat"  }
p [1,2,3,4].my_map_2 { |i| i*i }      
p [1,2,3,4].my_map_2(&bloc)    
puts "\n"
print "-------------------"
puts "\n"
print "-------------------"
puts "\n"
print "-------my_inject---------"
puts "\n"
p [5,6,7,8,9,10].my_inject { |sum, n| sum + n }            #=> 45
p [5,6,7,8,9,10].my_inject(1) { |product, n| product * n } #=> 151200
longest = %w{ cat sheep bear }.my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
p longest                                        #=> "sheep"
puts "\n"
print "-------------------"
