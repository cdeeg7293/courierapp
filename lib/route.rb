class Route
  def initialize(length = 0.0, waypoints = [])
    @length = length
    @waypoints = waypoints
  end
  
  def add_waypoint(new_waypoint, length_to_add)
    @length += length_to_add
    @waypoints.push(new_waypoint)
  end
  
  def length
    @length
  end
  
  def waypoints
    @waypoints
  end
  
  def last_waypoint
    @waypoints.last
  end
  
  def remove_last_waypoint
    @waypoints.pop
  end
  
  def set_max_length
    @length = Float::MAX
  end
  
  def clone
    Route.new(self.length, self.waypoints.clone)
  end
  
  #maybe explicit clone function needed?
end
    
