require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_index=0
  end

  # [1,2,3, , 5,6]
  # @start_index = 4
  # index = 4
  # index_val = 7%6 = 1
  # O(1)
  def [](index)
    raise "index out of bounds" if @length == 0
    index_val = (@start_index + index) % @capacity
    raise "index out of bounds" if @store[index_val] == nil
    @store[index_val]
  end

  # O(1)
  def []=(index, val)
    index_val = (@start_index + index) % @capacity
    @store[index_val] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = @store[(@start_index + @length -1) % @capacity]
    @length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @capacity == @length
    val_index = (@start_index + @length) % @capacity
    @store[val_index] = val
    @length += 1
  end

  # [4, , , , 3, 5, 4, 2, 7, 5]
  # @start_index = 4
  # @length = 6
  # @capacity = 10
  #
  #
  # [4, 4, 3, , 5]
  # @start_index = 0 #before
  # @start_index = 4 #after unshift
  # @length = 3 #before
  # @length = 4 #after unshift

  # [2, , 1]

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    val = @store[@start_index]
    @start_index += 1
    @start_index %= @capacity
    @length -= 1
    val
  end

## unshift,

  # O(1) ammortized
  def unshift(val)
    resize! if @capacity == @length #deal without this for now

    # @store[@length] = val
    # @start_index = @length
    # @length += 1

    @start_index -= 1
    @start_index %= @capacity
    @store[@start_index] = val
    @length += 1

  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  # [2,3,4,1]
  # @start_index = 3
  # @capacity = 4
  # @length = 4
  #
  # [1,2,3,4, , , , ]
  # @start_index = 0
  # @capacity = 8
  # @length = 4

  def resize!
    new_capacity = @capacity * 2
    newStore = StaticArray.new(new_capacity)
    i=0
    while i < @capacity
      newStore[i] = @store[(@start_index + i) % @capacity]
      i+=1
    end
    @store = newStore
    @capacity = new_capacity
    @start_index = 0

    # @capacity *= 2
    # newStore = StaticArray.new(@capacity)
    # @length.times do |i|
    #   newStore[i] = @store[i]
    # end
    # @store = newStore
  end
end
