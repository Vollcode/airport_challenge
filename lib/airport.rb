require 'plane'
require 'weather'
# checking on Git
class Airport
    attr_reader :capacity, :airport_space

  DEFAULT_CAPACITY = 10

  def initialize(capacity=DEFAULT_CAPACITY)
    @airport_space = []
    @capacity = capacity
  end

  def plane_exit
    fail "Can't let the plane out with this weather" if stormy?
    fail "Can't take where there is none" if empty
    @airport_space.pop.take_off
  end

  def arrival(planes)
    fail "Can't let you land in this weather" if stormy?
    fail "No more planes for today mate" if full?
    planes.land
    @airport_space << planes
  end

  private

  def full?
    @airport_space.length >= @capacity
  end

  def empty
    @airport_space.empty?
  end
end
