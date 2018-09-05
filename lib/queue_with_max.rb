# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @length = 0
    # @max = 0
    # @max_index = 0
  end

  def enqueue(val)
    @store.push(val)
    @length += 1
    # if val > @max
    #   @max = val
    #   @max_index = @length - 1
    # end
  end

  def dequeue
    @store.shift
    @length -= 1
  end

  def max #not O(1)
    max = @store[0]
    @length.times do |i|
      max = @store[i] if @store[i] > max
    end
    max
  end

  def length
    @length
  end

end
