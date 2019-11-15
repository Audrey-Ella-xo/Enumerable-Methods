# frozen_string_literal: true

require_relative '../enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    it 'returns an enumerable if not passed a block' do
      expect([1, 2, 3].my_each).to be_a(Enumerable)
    end

    it 'does the block on each member' do
      output = []
      [1, 2, 3].my_each { |element| output << element + 1 }
      expect(output).to eql([2, 3, 4])
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerable if not passed a block' do
      expect([1, 2, 3].my_each_with_index).to be_a(Enumerable)
    end

    it 'does the block on each member' do
      output = []
      [1, 2, 3].my_each_with_index { |element, index| output << [element, index] }
      expect(output).to eql([[1, 0], [2, 1], [3, 2]])
    end
  end

  describe '#my_select' do
    it 'returns an enumerable if not passed a block' do
      expect([1, 2, 3].my_select).to be_a(Enumerable)
    end

    it 'does the block on each member' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eql([2, 4])
    end
  end

  describe '#my_map' do
    it 'returns an enumerable if not passed a block' do
      expect([1, 2, 3].my_map).to be_a(Enumerable)
    end

    it 'does the block on each member' do
      expect([1, 2, 3, 4].my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
  end

  describe '#my_count' do
    it 'counts my_all the elements in the array' do
      expect([1, 2, 4, 2].my_count).to eql(4)
    end

    it 'counts my_all the elements in the array' do
      expect([1, 2, 4, 2].my_count(2)).to eql(2)
    end

    it 'does the block on each member' do
      expect([1, 2, 4, 2].my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_all?' do
    it 'does the block on each member' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'checks if argument is a regex' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'checks if an argument is a member of a class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'when no block is given, returns true when none of the collection members are false or nill' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'when no block is given, returns true when none of the collection members are false or nill' do
      expect([].my_all?).to eql(true)
    end
  end
end
