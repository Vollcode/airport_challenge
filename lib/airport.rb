require_relative 'plane'
require_relative 'weather'

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
    fail "No more planes for today mate" if full?
    fail "This plane is already on land" if plane_on_land(planes)
    fail "Can't let you land in this weather" if stormy?
    planes.land
    @airport_space << planes
  end

  def plane_on_land(planes)
    plane = planes.object_id
    @airport_space.include?(plane)
  end

  private

  def full?
    @airport_space.length >= @capacity
  end

  def empty
    @airport_space.empty?
  end
end
