require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  def length
    @length
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @store[index] == nil
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @capacity == @length
    store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    @store = @store[1..-1]
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @capacity == @length
    newStore = StaticArray.new(@capacity+1)
    newStore[0] = val
    i=0
    while i<@length
      newStore[i+1] = @store[i]
      i+=1
    end
    @store = newStore
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    newStore = StaticArray.new(@capacity)
    @length.times do |i|
      newStore[i] = @store[i]
    end
    @store = newStore
  end
end
